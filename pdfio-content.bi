#pragma once

#include once "crt/stdio.bi"
#include once "crt/stdlib.bi"
#include once "stdbool.bi"
#include once "crt/sys/types.bi"
#include once "crt/time.bi"

extern "C"

#define PDFIO_CONTENT_H
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

type pdfio_cs_e as long
enum
	PDFIO_CS_ADOBE
	PDFIO_CS_P3_D65
	PDFIO_CS_SRGB
end enum

type pdfio_cs_t as pdfio_cs_e

type pdfio_linecap_e as long
enum
	PDFIO_LINECAP_BUTT
	PDFIO_LINECAP_ROUND
	PDFIO_LINECAP_SQUARE
end enum

type pdfio_linecap_t as pdfio_linecap_e

type pdfio_linejoin_e as long
enum
	PDFIO_LINEJOIN_MITER
	PDFIO_LINEJOIN_ROUND
	PDFIO_LINEJOIN_BEVEL
end enum

type pdfio_linejoin_t as pdfio_linejoin_e

type pdfio_textrendering_e as long
enum
	PDFIO_TEXTRENDERING_FILL
	PDFIO_TEXTRENDERING_STROKE
	PDFIO_TEXTRENDERING_FILL_AND_STROKE
	PDFIO_TEXTRENDERING_INVISIBLE
	PDFIO_TEXTRENDERING_FILL_PATH
	PDFIO_TEXTRENDERING_STROKE_PATH
	PDFIO_TEXTRENDERING_FILL_AND_STROKE_PATH
	PDFIO_TEXTRENDERING_TEXT_PATH
end enum

type pdfio_textrendering_t as pdfio_textrendering_e
declare function pdfioArrayCreateColorFromICCObj(byval pdf as pdfio_file_t ptr, byval icc_object as pdfio_obj_t ptr) as pdfio_array_t ptr
declare function pdfioArrayCreateColorFromMatrix(byval pdf as pdfio_file_t ptr, byval num_colors as uinteger, byval gamma as double, byval matrix as const double ptr, byval white_point as const double ptr) as pdfio_array_t ptr
declare function pdfioArrayCreateColorFromPalette(byval pdf as pdfio_file_t ptr, byval num_colors as uinteger, byval colors as const ubyte ptr) as pdfio_array_t ptr
declare function pdfioArrayCreateColorFromPrimaries(byval pdf as pdfio_file_t ptr, byval num_colors as uinteger, byval gamma as double, byval wx as double, byval wy as double, byval rx as double, byval ry as double, byval gx as double, byval gy as double, byval bx as double, byval by as double) as pdfio_array_t ptr
declare function pdfioArrayCreateColorFromStandard(byval pdf as pdfio_file_t ptr, byval num_colors as uinteger, byval cs as pdfio_cs_t) as pdfio_array_t ptr
declare function pdfioContentClip(byval st as pdfio_stream_t ptr, byval even_odd as bool) as bool
declare function pdfioContentDrawImage(byval st as pdfio_stream_t ptr, byval name as const zstring ptr, byval x as double, byval y as double, byval w as double, byval h as double) as bool
declare function pdfioContentFill(byval st as pdfio_stream_t ptr, byval even_odd as bool) as bool
declare function pdfioContentFillAndStroke(byval st as pdfio_stream_t ptr, byval even_odd as bool) as bool
declare function pdfioContentMatrixConcat(byval st as pdfio_stream_t ptr, byval m as double ptr) as bool
declare function pdfioContentMatrixRotate(byval st as pdfio_stream_t ptr, byval degrees as double) as bool
declare function pdfioContentMatrixScale(byval st as pdfio_stream_t ptr, byval sx as double, byval sy as double) as bool
declare function pdfioContentMatrixTranslate(byval st as pdfio_stream_t ptr, byval tx as double, byval ty as double) as bool
declare function pdfioContentPathClose(byval st as pdfio_stream_t ptr) as bool
declare function pdfioContentPathCurve(byval st as pdfio_stream_t ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double, byval x3 as double, byval y3 as double) as bool
declare function pdfioContentPathCurve13(byval st as pdfio_stream_t ptr, byval x1 as double, byval y1 as double, byval x3 as double, byval y3 as double) as bool
declare function pdfioContentPathCurve23(byval st as pdfio_stream_t ptr, byval x2 as double, byval y2 as double, byval x3 as double, byval y3 as double) as bool
declare function pdfioContentPathEnd(byval st as pdfio_stream_t ptr) as bool
declare function pdfioContentPathLineTo(byval st as pdfio_stream_t ptr, byval x as double, byval y as double) as bool
declare function pdfioContentPathMoveTo(byval st as pdfio_stream_t ptr, byval x as double, byval y as double) as bool
declare function pdfioContentPathRect(byval st as pdfio_stream_t ptr, byval x as double, byval y as double, byval width as double, byval height as double) as bool
declare function pdfioContentRestore(byval st as pdfio_stream_t ptr) as bool
declare function pdfioContentSave(byval st as pdfio_stream_t ptr) as bool
declare function pdfioContentSetDashPattern(byval st as pdfio_stream_t ptr, byval phase as double, byval on as double, byval off as double) as bool
declare function pdfioContentSetFillColorDeviceCMYK(byval st as pdfio_stream_t ptr, byval c as double, byval m as double, byval y as double, byval k as double) as bool
declare function pdfioContentSetFillColorDeviceGray(byval st as pdfio_stream_t ptr, byval g as double) as bool
declare function pdfioContentSetFillColorDeviceRGB(byval st as pdfio_stream_t ptr, byval r as double, byval g as double, byval b as double) as bool
declare function pdfioContentSetFillColorGray(byval st as pdfio_stream_t ptr, byval g as double) as bool
declare function pdfioContentSetFillColorRGB(byval st as pdfio_stream_t ptr, byval r as double, byval g as double, byval b as double) as bool
declare function pdfioContentSetFillColorSpace(byval st as pdfio_stream_t ptr, byval name as const zstring ptr) as bool
declare function pdfioContentSetFlatness(byval st as pdfio_stream_t ptr, byval f as double) as bool
declare function pdfioContentSetLineCap(byval st as pdfio_stream_t ptr, byval lc as pdfio_linecap_t) as bool
declare function pdfioContentSetLineJoin(byval st as pdfio_stream_t ptr, byval lj as pdfio_linejoin_t) as bool
declare function pdfioContentSetLineWidth(byval st as pdfio_stream_t ptr, byval width as double) as bool
declare function pdfioContentSetMiterLimit(byval st as pdfio_stream_t ptr, byval limit as double) as bool
declare function pdfioContentSetStrokeColorDeviceCMYK(byval st as pdfio_stream_t ptr, byval c as double, byval m as double, byval y as double, byval k as double) as bool
declare function pdfioContentSetStrokeColorDeviceGray(byval st as pdfio_stream_t ptr, byval g as double) as bool
declare function pdfioContentSetStrokeColorDeviceRGB(byval st as pdfio_stream_t ptr, byval r as double, byval g as double, byval b as double) as bool
declare function pdfioContentSetStrokeColorGray(byval st as pdfio_stream_t ptr, byval g as double) as bool
declare function pdfioContentSetStrokeColorRGB(byval st as pdfio_stream_t ptr, byval r as double, byval g as double, byval b as double) as bool
declare function pdfioContentSetStrokeColorSpace(byval st as pdfio_stream_t ptr, byval name as const zstring ptr) as bool
declare function pdfioContentSetTextCharacterSpacing(byval st as pdfio_stream_t ptr, byval spacing as double) as bool
declare function pdfioContentSetTextFont(byval st as pdfio_stream_t ptr, byval name as const zstring ptr, byval size as double) as bool
declare function pdfioContentSetTextLeading(byval st as pdfio_stream_t ptr, byval leading as double) as bool
declare function pdfioContentSetTextMatrix(byval st as pdfio_stream_t ptr, byval m as double ptr) as bool
declare function pdfioContentSetTextRenderingMode(byval st as pdfio_stream_t ptr, byval mode as pdfio_textrendering_t) as bool
declare function pdfioContentSetTextRise(byval st as pdfio_stream_t ptr, byval rise as double) as bool
declare function pdfioContentSetTextWordSpacing(byval st as pdfio_stream_t ptr, byval spacing as double) as bool
declare function pdfioContentSetTextXScaling(byval st as pdfio_stream_t ptr, byval percent as double) as bool
declare function pdfioContentStroke(byval st as pdfio_stream_t ptr) as bool
declare function pdfioContentTextBegin(byval st as pdfio_stream_t ptr) as bool
declare function pdfioContentTextEnd(byval st as pdfio_stream_t ptr) as bool
declare function pdfioContentTextMoveLine(byval st as pdfio_stream_t ptr, byval tx as double, byval ty as double) as bool
declare function pdfioContentTextMoveTo(byval st as pdfio_stream_t ptr, byval tx as double, byval ty as double) as bool
declare function pdfioContentTextNextLine(byval st as pdfio_stream_t ptr) as bool
declare function pdfioContentTextShow(byval st as pdfio_stream_t ptr, byval unicode as bool, byval s as const zstring ptr) as bool
declare function pdfioContentTextShowf(byval st as pdfio_stream_t ptr, byval unicode as bool, byval format as const zstring ptr, ...) as bool
declare function pdfioContentTextShowJustified(byval st as pdfio_stream_t ptr, byval unicode as bool, byval num_fragments as uinteger, byval offsets as const double ptr, byval fragments as const zstring const ptr ptr) as bool
declare function pdfioFileCreateFontObjFromBase(byval pdf as pdfio_file_t ptr, byval name as const zstring ptr) as pdfio_obj_t ptr
declare function pdfioFileCreateFontObjFromFile(byval pdf as pdfio_file_t ptr, byval filename as const zstring ptr, byval unicode as bool) as pdfio_obj_t ptr
declare function pdfioFileCreateICCObjFromFile(byval pdf as pdfio_file_t ptr, byval filename as const zstring ptr, byval num_colors as uinteger) as pdfio_obj_t ptr
declare function pdfioFileCreateImageObjFromData(byval pdf as pdfio_file_t ptr, byval data as const ubyte ptr, byval width as uinteger, byval height as uinteger, byval num_colors as uinteger, byval color_data as pdfio_array_t ptr, byval alpha as bool, byval interpolate as bool) as pdfio_obj_t ptr
declare function pdfioFileCreateImageObjFromFile(byval pdf as pdfio_file_t ptr, byval filename as const zstring ptr, byval interpolate as bool) as pdfio_obj_t ptr
declare function pdfioImageGetBytesPerLine(byval obj as pdfio_obj_t ptr) as uinteger
declare function pdfioImageGetHeight(byval obj as pdfio_obj_t ptr) as double
declare function pdfioImageGetWidth(byval obj as pdfio_obj_t ptr) as double
declare function pdfioPageDictAddColorSpace(byval dict as pdfio_dict_t ptr, byval name as const zstring ptr, byval data as pdfio_array_t ptr) as bool
declare function pdfioPageDictAddFont(byval dict as pdfio_dict_t ptr, byval name as const zstring ptr, byval obj as pdfio_obj_t ptr) as bool
declare function pdfioPageDictAddImage(byval dict as pdfio_dict_t ptr, byval name as const zstring ptr, byval obj as pdfio_obj_t ptr) as bool

end extern
