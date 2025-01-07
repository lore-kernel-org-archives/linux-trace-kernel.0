Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A6219ED;
	Tue,  7 Jan 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736247905; cv=none; b=JNhcNdIpRCMoZY+d2b2Wji0CmLYByup17bVJCnOU7zi8NI/unEeh2Rdyn2ZFgvFqMK0mczdlBFratTg1fVlDC92Yfr4X2x1i0v4I3b5LgWEijD1tyyAqCns2TG6/KRqj43R3lgMsb+tvsFI6+jBOj3Aj6tFJYx5aZNf1jly89Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736247905; c=relaxed/simple;
	bh=Io4VEOd7xg6UAAPK28Zo4vAcsTYcYfoIx3bQ/AVcvgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ti6V5Ujid/N+jbAEDhwkOPiAr3UeaU9txtRCFcG+pOw1lGNovzsOUkKKGxjenP4oVefIy4+vTi1bfdcf4gRc5nem29B9E8Uxo5ENQQKfaBMjTVDekxU8UIC8bPMvlkkrysWwqMqQKg9n2f4rx/Jo3g6hsTI5BE2DVwQwytcqxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YS7PQ0dyFz6JB59;
	Tue,  7 Jan 2025 19:00:26 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 65F0A1409EA;
	Tue,  7 Jan 2025 19:04:58 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 7 Jan 2025 12:04:58 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 7 Jan 2025 12:04:58 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linuxarm
	<linuxarm@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH 1/1] tracing: Support reading trace event format file
 larger than PAGE_SIZE
Thread-Topic: [PATCH 1/1] tracing: Support reading trace event format file
 larger than PAGE_SIZE
Thread-Index: AQHbXT3YBSfk6mCs00ebyq2K42O+ArMJ88IAgAASVXCAAD6hAIAA5caA
Date: Tue, 7 Jan 2025 11:04:57 +0000
Message-ID: <b108b7edec16444ab04da770c796c60c@huawei.com>
References: <20250102174317.1594-1-shiju.jose@huawei.com>
	<20250106122204.0f16cb58@gandalf.local.home>
	<edd0ebb243684fc0a14e8974c8dabf8a@huawei.com>
 <20250106171150.4d3da6e5@gandalf.local.home>
In-Reply-To: <20250106171150.4d3da6e5@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
Content-Type: multipart/mixed;
	boundary="_002_b108b7edec16444ab04da770c796c60chuaweicom_"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--_002_b108b7edec16444ab04da770c796c60chuaweicom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>-----Original Message-----
>From: Steven Rostedt <rostedt@goodmis.org>
>Sent: 06 January 2025 22:12
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: mhiramat@kernel.org; mathieu.desnoyers@efficios.com; linux-trace-
>kernel@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
><linuxarm@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: Re: [PATCH 1/1] tracing: Support reading trace event format file =
larger
>than PAGE_SIZE
>
>On Mon, 6 Jan 2025 18:15:36 +0000
>Shiju Jose <shiju.jose@huawei.com> wrote:
>
>> >You see, it requires multiple reads to pull in an entire kernel
>> >pseudo file. None of those reads are greater than PAGE_SIZE. Why
>> >should trace format files be any different?
>> Thanks for the reply.
>> Yes. I had a fix/workaround in the userspace rasdaemon with multiple
>> reads like above as reported previously in the  following thread.
>> https://lore.kernel.org/lkml/3c9808a694d242cab35bab67602edebf@huawei.c
>> om/ However thought a solution in the common kernel code for the
>> format file may be better.  I will go ahead with the user space
>> solution.
>
>That would make it different than every other pseudo file in the kernel. I=
 rather
>not do that.
>
>>
>> Also shared an information in the above thread about libtraceevent
>> __parse_event() does not return error when parse_format() fail with
>> incomplete formt data, which resulted initialization for the trace event=
 does
>not fail in the user space tool.
>
>Hmm, can you send me the the format file that failed?
>
>Just the output of "cat /sys/kernel/tracing/events/<system>/<event>/format=
"
>will do.

Please find attached format file, which might have failed to parse because =
of the
unsupported formats in the libtraceevent you mentioned in the following thr=
ead.
https://lore.kernel.org/lkml/20241127104132.6c1729e1@gandalf.local.home/#t =
  =20

Please find the improvement in the libraceevent which I mentioned for not r=
eturning error
when parsing failed,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/src/event-parse.c b/src/event-parse.c index 0427061..b9264cb 1=
00644
--- a/src/event-parse.c
+++ b/src/event-parse.c
@@ -7905,9 +7905,14 @@ __parse_event(struct tep_handle *tep,
              const char *buf, unsigned long size,
              const char *sys)
 {
-       int ret =3D parse_format(eventp, tep, buf, size, sys);
-       struct tep_event *event =3D *eventp;
+       int ret;
+       struct tep_event *event;
+
+       ret =3D parse_format(eventp, tep, buf, size, sys);
+       if (ret)
+               return ret;
=20
+       event =3D *eventp;
        if (event =3D=3D NULL)
                return ret;=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =20
>
>-- Steve

Thanks,
Shiju

--_002_b108b7edec16444ab04da770c796c60chuaweicom_
Content-Type: application/octet-stream; name="format_cxl_general_media"
Content-Description: format_cxl_general_media
Content-Disposition: attachment; filename="format_cxl_general_media";
	size=5089; creation-date="Tue, 07 Jan 2025 10:54:04 GMT";
	modification-date="Tue, 07 Jan 2025 10:33:42 GMT"
Content-Transfer-Encoding: base64

bmFtZTogY3hsX2dlbmVyYWxfbWVkaWEKSUQ6IDE0OTcKZm9ybWF0OgoJZmllbGQ6dW5zaWduZWQg
c2hvcnQgY29tbW9uX3R5cGU7CW9mZnNldDowOwlzaXplOjI7CXNpZ25lZDowOwoJZmllbGQ6dW5z
aWduZWQgY2hhciBjb21tb25fZmxhZ3M7CW9mZnNldDoyOwlzaXplOjE7CXNpZ25lZDowOwoJZmll
bGQ6dW5zaWduZWQgY2hhciBjb21tb25fcHJlZW1wdF9jb3VudDsJb2Zmc2V0OjM7CXNpemU6MTsJ
c2lnbmVkOjA7CglmaWVsZDppbnQgY29tbW9uX3BpZDsJb2Zmc2V0OjQ7CXNpemU6NDsJc2lnbmVk
OjE7CgoJZmllbGQ6X19kYXRhX2xvYyBjaGFyW10gbWVtZGV2OwlvZmZzZXQ6ODsJc2l6ZTo0Owlz
aWduZWQ6MDsKCWZpZWxkOl9fZGF0YV9sb2MgY2hhcltdIGhvc3Q7CW9mZnNldDoxMjsJc2l6ZTo0
OwlzaWduZWQ6MDsKCWZpZWxkOmludCBsb2c7CW9mZnNldDoxNjsJc2l6ZTo0OwlzaWduZWQ6MTsK
CWZpZWxkOnV1aWRfdCBoZHJfdXVpZDsJb2Zmc2V0OjIwOwlzaXplOjE2OwlzaWduZWQ6MDsKCWZp
ZWxkOnU2NCBzZXJpYWw7CW9mZnNldDo0MDsJc2l6ZTo4OwlzaWduZWQ6MDsKCWZpZWxkOnUzMiBo
ZHJfZmxhZ3M7CW9mZnNldDo0ODsJc2l6ZTo0OwlzaWduZWQ6MDsKCWZpZWxkOnUxNiBoZHJfaGFu
ZGxlOwlvZmZzZXQ6NTI7CXNpemU6MjsJc2lnbmVkOjA7CglmaWVsZDp1MTYgaGRyX3JlbGF0ZWRf
aGFuZGxlOwlvZmZzZXQ6NTQ7CXNpemU6MjsJc2lnbmVkOjA7CglmaWVsZDp1NjQgaGRyX3RpbWVz
dGFtcDsJb2Zmc2V0OjU2OwlzaXplOjg7CXNpZ25lZDowOwoJZmllbGQ6dTggaGRyX2xlbmd0aDsJ
b2Zmc2V0OjY0OwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dTggaGRyX21haW50X29wX2NsYXNz
OwlvZmZzZXQ6NjU7CXNpemU6MTsJc2lnbmVkOjA7CglmaWVsZDp1OCBoZHJfbWFpbnRfb3Bfc3Vi
X2NsYXNzOwlvZmZzZXQ6NjY7CXNpemU6MTsJc2lnbmVkOjA7CglmaWVsZDp1NjQgZHBhOwlvZmZz
ZXQ6NzI7CXNpemU6ODsJc2lnbmVkOjA7CglmaWVsZDp1OCBkZXNjcmlwdG9yOwlvZmZzZXQ6ODA7
CXNpemU6MTsJc2lnbmVkOjA7CglmaWVsZDp1OCB0eXBlOwlvZmZzZXQ6ODE7CXNpemU6MTsJc2ln
bmVkOjA7CglmaWVsZDp1OCBzdWJfdHlwZTsJb2Zmc2V0OjgyOwlzaXplOjE7CXNpZ25lZDowOwoJ
ZmllbGQ6dTggdHJhbnNhY3Rpb25fdHlwZTsJb2Zmc2V0OjgzOwlzaXplOjE7CXNpZ25lZDowOwoJ
ZmllbGQ6dTggY2hhbm5lbDsJb2Zmc2V0Ojg0OwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dTMy
IGRldmljZTsJb2Zmc2V0Ojg4OwlzaXplOjQ7CXNpZ25lZDowOwoJZmllbGQ6dTggY29tcF9pZFsx
Nl07CW9mZnNldDo5MjsJc2l6ZToxNjsJc2lnbmVkOjA7CglmaWVsZDp1NjQgaHBhOwlvZmZzZXQ6
MTEyOwlzaXplOjg7CXNpZ25lZDowOwoJZmllbGQ6dXVpZF90IHJlZ2lvbl91dWlkOwlvZmZzZXQ6
MTIwOwlzaXplOjE2OwlzaWduZWQ6MDsKCWZpZWxkOnUxNiB2YWxpZGl0eV9mbGFnczsJb2Zmc2V0
OjEzNjsJc2l6ZToyOwlzaWduZWQ6MDsKCWZpZWxkOnU4IHJhbms7CW9mZnNldDoxMzg7CXNpemU6
MTsJc2lnbmVkOjA7CglmaWVsZDp1OCBkcGFfZmxhZ3M7CW9mZnNldDoxMzk7CXNpemU6MTsJc2ln
bmVkOjA7CglmaWVsZDpfX2RhdGFfbG9jIGNoYXJbXSByZWdpb25fbmFtZTsJb2Zmc2V0OjE0MDsJ
c2l6ZTo0OwlzaWduZWQ6MDsKCWZpZWxkOnU4IGNtZV90aHJlc2hvbGRfZXZfZmxhZ3M7CW9mZnNl
dDoxNDQ7CXNpemU6MTsJc2lnbmVkOjA7CglmaWVsZDp1MzIgY21lX2NvdW50OwlvZmZzZXQ6MTQ4
OwlzaXplOjQ7CXNpZ25lZDowOwoKcHJpbnQgZm10OiAibWVtZGV2PSVzIGhvc3Q9JXMgc2VyaWFs
PSVsbGQgbG9nPSVzIDogdGltZT0lbGx1IHV1aWQ9JXBVYiBsZW49JWQgZmxhZ3M9JyVzJyBoYW5k
bGU9JXggcmVsYXRlZF9oYW5kbGU9JXggbWFpbnRfb3BfY2xhc3M9JXUgbWFpbnRfb3Bfc3ViX2Ns
YXNzPSV1IDogZHBhPSVsbHggZHBhX2ZsYWdzPSclcycgZGVzY3JpcHRvcj0nJXMnIHR5cGU9JyVz
JyBzdWJfdHlwZT0nJXMnIHRyYW5zYWN0aW9uX3R5cGU9JyVzJyBjaGFubmVsPSV1IHJhbms9JXUg
ZGV2aWNlPSV4IHZhbGlkaXR5X2ZsYWdzPSclcycgY29tcF9pZD0lcyBjb21wX2lkX3BsZG1fdmFs
aWRfZmxhZ3M9JyVzJyBwbGRtX2VudGl0eV9pZD0lcyBwbGRtX3Jlc291cmNlX2lkPSVzIGhwYT0l
bGx4IHJlZ2lvbj0lcyByZWdpb25fdXVpZD0lcFViIGNtZV90aHJlc2hvbGRfZXZfZmxhZ3M9JyVz
JyBjbWVfY291bnQ9JXgiLCBfX2dldF9zdHIobWVtZGV2KSwgX19nZXRfc3RyKGhvc3QpLCBSRUMt
PnNlcmlhbCwgX19wcmludF9zeW1ib2xpYyhSRUMtPmxvZywgeyBDWExfRVZFTlRfVFlQRV9JTkZP
LCAiSW5mb3JtYXRpb25hbCIgfSwgeyBDWExfRVZFTlRfVFlQRV9XQVJOLCAiV2FybmluZyIgfSwg
eyBDWExfRVZFTlRfVFlQRV9GQUlMLCAiRmFpbHVyZSIgfSwgeyBDWExfRVZFTlRfVFlQRV9GQVRB
TCwgIkZhdGFsIiB9KSwgUkVDLT5oZHJfdGltZXN0YW1wLCAmUkVDLT5oZHJfdXVpZCwgUkVDLT5o
ZHJfbGVuZ3RoLCBfX3ByaW50X2ZsYWdzKFJFQy0+aGRyX2ZsYWdzLCAiIHwgIiwgeyAoKCgoMVVM
KSkpIDw8ICgyKSksICJQRVJNQU5FTlRfQ09ORElUSU9OIiB9LCB7ICgoKCgxVUwpKSkgPDwgKDMp
KSwgIk1BSU5URU5BTkNFX05FRURFRCIgfSwgeyAoKCgoMVVMKSkpIDw8ICg0KSksICJQRVJGT1JN
QU5DRV9ERUdSQURFRCIgfSwgeyAoKCgoMVVMKSkpIDw8ICg1KSksICJIQVJEV0FSRV9SRVBMQUNF
TUVOVF9ORUVERUQiIH0sIHsgKCgoKDFVTCkpKSA8PCAoNikpLCAiTUFJTlRfT1BfU1VCX0NMQVNT
X1ZBTElEIiB9ICksIFJFQy0+aGRyX2hhbmRsZSwgUkVDLT5oZHJfcmVsYXRlZF9oYW5kbGUsIFJF
Qy0+aGRyX21haW50X29wX2NsYXNzLCBSRUMtPmhkcl9tYWludF9vcF9zdWJfY2xhc3MsIFJFQy0+
ZHBhLCBfX3ByaW50X2ZsYWdzKFJFQy0+ZHBhX2ZsYWdzLCAifCIsIHsgKCgoKDFVTCkpKSA8PCAo
MCkpLCAiVk9MQVRJTEUiIH0sIHsgKCgoKDFVTCkpKSA8PCAoMSkpLCAiTk9UX1JFUEFJUkFCTEUi
IH0gKSwgX19wcmludF9mbGFncyhSRUMtPmRlc2NyaXB0b3IsICJ8IiwgeyAoKCgoMVVMKSkpIDw8
ICgwKSksICJVTkNPUlJFQ1RBQkxFX0VWRU5UIiB9LCB7ICgoKCgxVUwpKSkgPDwgKDEpKSwgIlRI
UkVTSE9MRF9FVkVOVCIgfSwgeyAoKCgoMVVMKSkpIDw8ICgyKSksICJQT0lTT05fTElTVF9PVkVS
RkxPVyIgfSApLCBfX3ByaW50X3N5bWJvbGljKFJFQy0+dHlwZSwgeyAweDAwLCAiRUNDIEVycm9y
IiB9LCB7IDB4MDEsICJJbnZhbGlkIEFkZHJlc3MiIH0sIHsgMHgwMiwgIkRhdGEgUGF0aCBFcnJv
ciIgfSwgeyAweDAzLCAiVEUgU3RhdGUgVmlvbGF0aW9uIiB9LCB7IDB4MDQsICJTY3J1YiBNZWRp
YSBFQ0MgRXJyb3IiIH0sIHsgMHgwNSwgIkFkdiBQcm9nIENNRSBDb3VudGVyIEV4cGlyYXRpb24i
IH0sIHsgMHgwNiwgIkNLSUQgVmlvbGF0aW9uIiB9ICksIF9fcHJpbnRfc3ltYm9saWMoUkVDLT5z
dWJfdHlwZSwgeyAweDAwLCAiTm90IFJlcG9ydGVkIiB9LCB7IDB4MDEsICJJbnRlcm5hbCBEYXRh
cGF0aCBFcnJvciIgfSwgeyAweDAyLCAiTWVkaWEgTGluayBDb21tYW5kIFRyYWluaW5nIEVycm9y
IiB9LCB7IDB4MDMsICJNZWRpYSBMaW5rIENvbnRyb2wgVHJhaW5pbmcgRXJyb3IiIH0sIHsgMHgw
NCwgIk1lZGlhIExpbmsgRGF0YSBUcmFpbmluZyBFcnJvciIgfSwgeyAweDA1LCAiTWVkaWEgTGlu
ayBDUkMgRXJyb3IiIH0gKSwgX19wcmludF9zeW1ib2xpYyhSRUMtPnRyYW5zYWN0aW9uX3R5cGUs
IHsgMHgwMCwgIlVua25vd24iIH0sIHsgMHgwMSwgIkhvc3QgUmVhZCIgfSwgeyAweDAyLCAiSG9z
dCBXcml0ZSIgfSwgeyAweDAzLCAiSG9zdCBTY2FuIE1lZGlhIiB9LCB7IDB4MDQsICJIb3N0IElu
amVjdCBQb2lzb24iIH0sIHsgMHgwNSwgIkludGVybmFsIE1lZGlhIFNjcnViIiB9LCB7IDB4MDYs
ICJJbnRlcm5hbCBNZWRpYSBNYW5hZ2VtZW50IiB9LCB7IDB4MDcsICJJbnRlcm5hbCBNZWRpYSBF
cnJvciBDaGVjayBTY3J1YiIgfSwgeyAweDA4LCAiTWVkaWEgSW5pdGlhbGl6YXRpb24iIH0gKSwg
UkVDLT5jaGFubmVsLCBSRUMtPnJhbmssIFJFQy0+ZGV2aWNlLCBfX3ByaW50X2ZsYWdzKFJFQy0+
dmFsaWRpdHlfZmxhZ3MsICJ8IiwgeyAoKCgoMVVMKSkpIDw8ICgwKSksICJDSEFOTkVMIiB9LCB7
ICgoKCgxVUwpKSkgPDwgKDEpKSwgIlJBTksiIH0sIHsgKCgoKDFVTCkpKSA8PCAoMikpLCAiREVW
SUNFIiB9LCB7ICgoKCgxVUwpKSkgPDwgKDMpKSwgIkNPTVBPTkVOVCIgfSwgeyAoKCgoMVVMKSkp
IDw8ICg0KSksICJDT01QT05FTlQgUExETSBGT1JNQVQiIH0gKSwgX19wcmludF9oZXgoUkVDLT5j
b21wX2lkLCAweDEwKSwgX19wcmludF9mbGFncyhSRUMtPmNvbXBfaWRbMF0sICIgfCAiLCB7ICgo
KCgxVUwpKSkgPDwgKDApKSwgIlBMRE0gRW50aXR5IElEIiB9LCB7ICgoKCgxVUwpKSkgPDwgKDEp
KSwgIlJlc291cmNlIElEIiB9ICksIChSRUMtPnZhbGlkaXR5X2ZsYWdzICYgKCgoKDFVTCkpKSA8
PCAoMykpICYmIFJFQy0+dmFsaWRpdHlfZmxhZ3MgJiAoKCgoMVVMKSkpIDw8ICg0KSkpID8gKFJF
Qy0+Y29tcF9pZFswXSAmICgoKCgxVUwpKSkgPDwgKDApKSkgPyBfX3ByaW50X2hleCgmUkVDLT5j
b21wX2lkWzFdLCA2KSA6ICIweDAwIiA6ICIweDAwIiwgKFJFQy0+dmFsaWRpdHlfZmxhZ3MgJiAo
KCgoMVVMKSkpIDw8ICgzKSkgJiYgUkVDLT52YWxpZGl0eV9mbGFncyAmICgoKCgxVUwpKSkgPDwg
KDQpKSkgPyAoUkVDLT5jb21wX2lkWzBdICYgKCgoKDFVTCkpKSA8PCAoMSkpKSA/IF9fcHJpbnRf
aGV4KCZSRUMtPmNvbXBfaWRbN10sIDQpIDogIjB4MDAiIDogIjB4MDAiLCBSRUMtPmhwYSwgX19n
ZXRfc3RyKHJlZ2lvbl9uYW1lKSwgJlJFQy0+cmVnaW9uX3V1aWQsIF9fcHJpbnRfZmxhZ3MoUkVD
LT5jbWVfdGhyZXNob2xkX2V2X2ZsYWdzLCAifCIsIHsgKCgoKDFVTCkpKSA8PCAoMCkpLCAiQ29y
cmVjdGVkIE1lbW9yeSBFcnJvcnMgaW4gTXVsdGlwbGUgTWVkaWEgQ29tcG9uZW50cyIgfSwgeyAo
KCgoMVVMKSkpIDw8ICgxKSksICJFeGNlZWRlZCBQcm9ncmFtbWFibGUgVGhyZXNob2xkIiB9ICks
IFJFQy0+Y21lX2NvdW50Cg==

--_002_b108b7edec16444ab04da770c796c60chuaweicom_--
