#pragma once

#include once "crt/stdio.bi"
#include once "crt/stdlib.bi"
#include once "stdbool.bi"
#include once "crt/sys/types.bi"
#include once "crt/time.bi"

extern "C"

#define PDFIO_H

#ifdef __FB_WIN32__
	type ssize_t as longint
#endif

type pdfio_array_t as _pdfio_array_s
type pdfio_dict_t as _pdfio_dict_s
type pdfio_dict_cb_t as function(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval cb_data as any ptr) as bool
type pdfio_file_t as _pdfio_file_s
type pdfio_error_cb_t as function(byval pdf as pdfio_file_t ptr, byval message as const zstring ptr, byval data as any ptr) as bool

type pdfio_encryption_e as long
enum
	PDFIO_ENCRYPTION_NONE = 0
	PDFIO_ENCRYPTION_RC4_40
	PDFIO_ENCRYPTION_RC4_128
	PDFIO_ENCRYPTION_AES_128
	PDFIO_ENCRYPTION_AES_256
end enum

type pdfio_encryption_t as pdfio_encryption_e

type pdfio_filter_e as long
enum
	PDFIO_FILTER_NONE
	PDFIO_FILTER_ASCIIHEX
	PDFIO_FILTER_ASCII85
	PDFIO_FILTER_CCITTFAX
	PDFIO_FILTER_CRYPT
	PDFIO_FILTER_DCT
	PDFIO_FILTER_FLATE
	PDFIO_FILTER_JBIG2
	PDFIO_FILTER_JPX
	PDFIO_FILTER_LZW
	PDFIO_FILTER_RUNLENGTH
end enum

type pdfio_filter_t as pdfio_filter_e
type pdfio_obj_t as _pdfio_obj_s
type pdfio_output_cb_t as function(byval ctx as any ptr, byval data as const any ptr, byval datalen as uinteger) as integer
type pdfio_password_cb_t as function(byval data as any ptr, byval filename as const zstring ptr) as const zstring ptr

type pdfio_permission_e as long
enum
	PDFIO_PERMISSION_NONE = 0
	PDFIO_PERMISSION_PRINT = &h0004
	PDFIO_PERMISSION_MODIFY = &h0008
	PDFIO_PERMISSION_COPY = &h0010
	PDFIO_PERMISSION_ANNOTATE = &h0020
	PDFIO_PERMISSION_FORMS = &h0100
	PDFIO_PERMISSION_READING = &h0200
	PDFIO_PERMISSION_ASSEMBLE = &h0400
	PDFIO_PERMISSION_PRINT_HIGH = &h0800
	PDFIO_PERMISSION_ALL = not 0
end enum

type pdfio_permission_t as long

type pdfio_rect_s
	x1 as double
	y1 as double
	x2 as double
	y2 as double
end type

type pdfio_rect_t as pdfio_rect_s
type pdfio_stream_t as _pdfio_stream_s

type pdfio_valtype_e as long
enum
	PDFIO_VALTYPE_NONE
	PDFIO_VALTYPE_ARRAY
	PDFIO_VALTYPE_BINARY
	PDFIO_VALTYPE_BOOLEAN
	PDFIO_VALTYPE_DATE
	PDFIO_VALTYPE_DICT
	PDFIO_VALTYPE_INDIRECT
	PDFIO_VALTYPE_NAME
	PDFIO_VALTYPE_NULL
	PDFIO_VALTYPE_NUMBER
	PDFIO_VALTYPE_STRING
end enum

type pdfio_valtype_t as pdfio_valtype_e
declare function pdfioArrayAppendArray(byval a as pdfio_array_t ptr, byval value as pdfio_array_t ptr) as bool
declare function pdfioArrayAppendBinary(byval a as pdfio_array_t ptr, byval value as const ubyte ptr, byval valuelen as uinteger) as bool
declare function pdfioArrayAppendBoolean(byval a as pdfio_array_t ptr, byval value as bool) as bool
declare function pdfioArrayAppendDate(byval a as pdfio_array_t ptr, byval value as time_t) as bool
declare function pdfioArrayAppendDict(byval a as pdfio_array_t ptr, byval value as pdfio_dict_t ptr) as bool
declare function pdfioArrayAppendName(byval a as pdfio_array_t ptr, byval value as const zstring ptr) as bool
declare function pdfioArrayAppendNumber(byval a as pdfio_array_t ptr, byval value as double) as bool
declare function pdfioArrayAppendObj(byval a as pdfio_array_t ptr, byval value as pdfio_obj_t ptr) as bool
declare function pdfioArrayAppendString(byval a as pdfio_array_t ptr, byval value as const zstring ptr) as bool
declare function pdfioArrayCopy(byval pdf as pdfio_file_t ptr, byval a as pdfio_array_t ptr) as pdfio_array_t ptr
declare function pdfioArrayCreate(byval pdf as pdfio_file_t ptr) as pdfio_array_t ptr
declare function pdfioArrayGetArray(byval a as pdfio_array_t ptr, byval n as uinteger) as pdfio_array_t ptr
declare function pdfioArrayGetBinary(byval a as pdfio_array_t ptr, byval n as uinteger, byval length as uinteger ptr) as ubyte ptr
declare function pdfioArrayGetBoolean(byval a as pdfio_array_t ptr, byval n as uinteger) as bool
declare function pdfioArrayGetDate(byval a as pdfio_array_t ptr, byval n as uinteger) as time_t
declare function pdfioArrayGetDict(byval a as pdfio_array_t ptr, byval n as uinteger) as pdfio_dict_t ptr
declare function pdfioArrayGetName(byval a as pdfio_array_t ptr, byval n as uinteger) as const zstring ptr
declare function pdfioArrayGetNumber(byval a as pdfio_array_t ptr, byval n as uinteger) as double
declare function pdfioArrayGetObj(byval a as pdfio_array_t ptr, byval n as uinteger) as pdfio_obj_t ptr
declare function pdfioArrayGetSize(byval a as pdfio_array_t ptr) as uinteger
declare function pdfioArrayGetString(byval a as pdfio_array_t ptr, byval n as uinteger) as const zstring ptr
declare function pdfioArrayGetType(byval a as pdfio_array_t ptr, byval n as uinteger) as pdfio_valtype_t
declare function pdfioDictCopy(byval pdf as pdfio_file_t ptr, byval dict as pdfio_dict_t ptr) as pdfio_dict_t ptr
declare function pdfioDictCreate(byval pdf as pdfio_file_t ptr) as pdfio_dict_t ptr
declare function pdfioDictGetArray(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr) as pdfio_array_t ptr
declare function pdfioDictGetBinary(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval length as uinteger ptr) as ubyte ptr
declare function pdfioDictGetBoolean(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr) as bool
declare function pdfioDictGetDate(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr) as time_t
declare function pdfioDictGetDict(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr) as pdfio_dict_t ptr
declare function pdfioDictGetName(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr) as const zstring ptr
declare function pdfioDictGetNumber(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr) as double
declare function pdfioDictGetObj(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr) as pdfio_obj_t ptr
declare function pdfioDictGetRect(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval rect as pdfio_rect_t ptr) as pdfio_rect_t ptr
declare function pdfioDictGetString(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr) as const zstring ptr
declare function pdfioDictGetType(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr) as pdfio_valtype_t
declare sub pdfioDictIterateKeys(byval dict as pdfio_dict_t ptr, byval cb as pdfio_dict_cb_t, byval cb_data as any ptr)
declare function pdfioDictSetArray(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval value as pdfio_array_t ptr) as bool
declare function pdfioDictSetBinary(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval value as const ubyte ptr, byval valuelen as uinteger) as bool
declare function pdfioDictSetBoolean(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval value as bool) as bool
declare function pdfioDictSetDate(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval value as time_t) as bool
declare function pdfioDictSetDict(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval value as pdfio_dict_t ptr) as bool
declare function pdfioDictSetName(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval value as const zstring ptr) as bool
declare function pdfioDictSetNull(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr) as bool
declare function pdfioDictSetNumber(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval value as double) as bool
declare function pdfioDictSetObj(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval value as pdfio_obj_t ptr) as bool
declare function pdfioDictSetRect(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval value as pdfio_rect_t ptr) as bool
declare function pdfioDictSetString(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval value as const zstring ptr) as bool
declare function pdfioDictSetStringf(byval dict as pdfio_dict_t ptr, byval key as const zstring ptr, byval format as const zstring ptr, ...) as bool
declare function pdfioFileClose(byval pdf as pdfio_file_t ptr) as bool
declare function pdfioFileCreate(byval filename as const zstring ptr, byval version as const zstring ptr, byval media_box as pdfio_rect_t ptr, byval crop_box as pdfio_rect_t ptr, byval error_cb as pdfio_error_cb_t, byval error_data as any ptr) as pdfio_file_t ptr
declare function pdfioFileCreateArrayObj(byval pdf as pdfio_file_t ptr, byval array as pdfio_array_t ptr) as pdfio_obj_t ptr
declare function pdfioFileCreateObj(byval pdf as pdfio_file_t ptr, byval dict as pdfio_dict_t ptr) as pdfio_obj_t ptr
declare function pdfioFileCreateOutput(byval output_cb as pdfio_output_cb_t, byval output_ctx as any ptr, byval version as const zstring ptr, byval media_box as pdfio_rect_t ptr, byval crop_box as pdfio_rect_t ptr, byval error_cb as pdfio_error_cb_t, byval error_data as any ptr) as pdfio_file_t ptr
declare function pdfioFileCreatePage(byval pdf as pdfio_file_t ptr, byval dict as pdfio_dict_t ptr) as pdfio_stream_t ptr
declare function pdfioFileCreateTemporary(byval buffer as zstring ptr, byval bufsize as uinteger, byval version as const zstring ptr, byval media_box as pdfio_rect_t ptr, byval crop_box as pdfio_rect_t ptr, byval error_cb as pdfio_error_cb_t, byval error_data as any ptr) as pdfio_file_t ptr
declare function pdfioFileFindObj(byval pdf as pdfio_file_t ptr, byval number as uinteger) as pdfio_obj_t ptr
declare function pdfioFileGetAuthor(byval pdf as pdfio_file_t ptr) as const zstring ptr
declare function pdfioFileGetCreationDate(byval pdf as pdfio_file_t ptr) as time_t
declare function pdfioFileGetCreator(byval pdf as pdfio_file_t ptr) as const zstring ptr
declare function pdfioFileGetID(byval pdf as pdfio_file_t ptr) as pdfio_array_t ptr
declare function pdfioFileGetKeywords(byval pdf as pdfio_file_t ptr) as const zstring ptr
declare function pdfioFileGetName(byval pdf as pdfio_file_t ptr) as const zstring ptr
declare function pdfioFileGetNumObjs(byval pdf as pdfio_file_t ptr) as uinteger
declare function pdfioFileGetNumPages(byval pdf as pdfio_file_t ptr) as uinteger
declare function pdfioFileGetObj(byval pdf as pdfio_file_t ptr, byval n as uinteger) as pdfio_obj_t ptr
declare function pdfioFileGetPage(byval pdf as pdfio_file_t ptr, byval n as uinteger) as pdfio_obj_t ptr
declare function pdfioFileGetPermissions(byval pdf as pdfio_file_t ptr, byval encryption as pdfio_encryption_t ptr) as pdfio_permission_t
declare function pdfioFileGetProducer(byval pdf as pdfio_file_t ptr) as const zstring ptr
declare function pdfioFileGetSubject(byval pdf as pdfio_file_t ptr) as const zstring ptr
declare function pdfioFileGetTitle(byval pdf as pdfio_file_t ptr) as const zstring ptr
declare function pdfioFileGetVersion(byval pdf as pdfio_file_t ptr) as const zstring ptr
declare function pdfioFileOpen(byval filename as const zstring ptr, byval password_cb as pdfio_password_cb_t, byval password_data as any ptr, byval error_cb as pdfio_error_cb_t, byval error_data as any ptr) as pdfio_file_t ptr
declare sub pdfioFileSetAuthor(byval pdf as pdfio_file_t ptr, byval value as const zstring ptr)
declare sub pdfioFileSetCreationDate(byval pdf as pdfio_file_t ptr, byval value as time_t)
declare sub pdfioFileSetCreator(byval pdf as pdfio_file_t ptr, byval value as const zstring ptr)
declare sub pdfioFileSetKeywords(byval pdf as pdfio_file_t ptr, byval value as const zstring ptr)
declare function pdfioFileSetPermissions(byval pdf as pdfio_file_t ptr, byval permissions as pdfio_permission_t, byval encryption as pdfio_encryption_t, byval owner_password as const zstring ptr, byval user_password as const zstring ptr) as bool
declare sub pdfioFileSetSubject(byval pdf as pdfio_file_t ptr, byval value as const zstring ptr)
declare sub pdfioFileSetTitle(byval pdf as pdfio_file_t ptr, byval value as const zstring ptr)
declare function pdfioObjClose(byval obj as pdfio_obj_t ptr) as bool
declare function pdfioObjCopy(byval pdf as pdfio_file_t ptr, byval srcobj as pdfio_obj_t ptr) as pdfio_obj_t ptr
declare function pdfioObjCreateStream(byval obj as pdfio_obj_t ptr, byval compression as pdfio_filter_t) as pdfio_stream_t ptr
declare function pdfioObjGetArray(byval obj as pdfio_obj_t ptr) as pdfio_array_t ptr
declare function pdfioObjGetDict(byval obj as pdfio_obj_t ptr) as pdfio_dict_t ptr
declare function pdfioObjGetGeneration(byval obj as pdfio_obj_t ptr) as ushort
declare function pdfioObjGetLength(byval obj as pdfio_obj_t ptr) as uinteger
declare function pdfioObjGetNumber(byval obj as pdfio_obj_t ptr) as uinteger
declare function pdfioObjGetSubtype(byval obj as pdfio_obj_t ptr) as const zstring ptr
declare function pdfioObjGetType(byval obj as pdfio_obj_t ptr) as const zstring ptr
declare function pdfioObjOpenStream(byval obj as pdfio_obj_t ptr, byval decode as bool) as pdfio_stream_t ptr
declare function pdfioPageCopy(byval pdf as pdfio_file_t ptr, byval srcpage as pdfio_obj_t ptr) as bool
declare function pdfioPageGetNumStreams(byval page as pdfio_obj_t ptr) as uinteger
declare function pdfioPageOpenStream(byval page as pdfio_obj_t ptr, byval n as uinteger, byval decode as bool) as pdfio_stream_t ptr
declare function pdfioStreamClose(byval st as pdfio_stream_t ptr) as bool
declare function pdfioStreamConsume(byval st as pdfio_stream_t ptr, byval bytes as uinteger) as bool
declare function pdfioStreamGetToken(byval st as pdfio_stream_t ptr, byval buffer as zstring ptr, byval bufsize as uinteger) as bool
declare function pdfioStreamPeek(byval st as pdfio_stream_t ptr, byval buffer as any ptr, byval bytes as uinteger) as integer
declare function pdfioStreamPrintf(byval st as pdfio_stream_t ptr, byval format as const zstring ptr, ...) as bool
declare function pdfioStreamPutChar(byval st as pdfio_stream_t ptr, byval ch as long) as bool
declare function pdfioStreamPuts(byval st as pdfio_stream_t ptr, byval s as const zstring ptr) as bool
declare function pdfioStreamRead(byval st as pdfio_stream_t ptr, byval buffer as any ptr, byval bytes as uinteger) as integer
declare function pdfioStreamWrite(byval st as pdfio_stream_t ptr, byval buffer as const any ptr, byval bytes as uinteger) as bool
declare function pdfioStringCreate(byval pdf as pdfio_file_t ptr, byval s as const zstring ptr) as zstring ptr
declare function pdfioStringCreatef(byval pdf as pdfio_file_t ptr, byval format as const zstring ptr, ...) as zstring ptr

end extern
