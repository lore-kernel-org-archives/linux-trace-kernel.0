Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592AD273D6F;
	Tue,  3 Feb 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111785; cv=none; b=RPCrZ2pAT3er2uNnwJHwQ4hVjFGzX79dKTdEH9nmgfESUUFOCVpm7reGsfkvRzdl9ZIHmFMUQXG9C4jX+OoRmAuiMQpr6DkbNr0OzE2X1FUZedRiwdi+w6Gg6wfV+6lWAp74tfyIjnwo6lwkDf8kg0AUJpz6Juj6evNVQMzdniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111785; c=relaxed/simple;
	bh=BBqmrOBZfPglA3MquBWmOIUaYTuDEQp+m2wYkxzueBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=dccN8hrVmsoGOI9s9l3Y/oSOTkD/raYY4vg7MMXgCiC9gXZ7i4GNMeOU31i4+mhgbZGLeX5dfspBE7PyNHeq75y+BqUWHh1+I3zXQzlPjldbC2FA3rYHzBd03ow/HBTy6+lm/OQ6GRIU9ZgY9PXaHAmy75cXyEcsHa+5kZt0lW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kIohwwlv; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kIohwwlv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=BBqmrOBZfPglA3MquBWmOIUaYTuDEQp+m2wYkxzueBw=; b=k
	IohwwlvtxKI2hRe+bvKdM8VcHH6zuLsYlRVHj2HD3RoUyTXiBi+EiPZ5oLziH0CN
	4mgkehVQGTQc0/OC2EKcVNGigM2kc118c7Cov87mMHgnSaoxar8Ls74FcOi8tgrr
	cp6oI/ruKsSAr0BhFJ6K+xjU08Q7GgqEKN9jUlS3Cs=
Received: from imntjempty$163.com ( [183.47.95.209] ) by
 ajax-webmail-wmsvr-40-144 (Coremail) ; Tue, 3 Feb 2026 17:42:29 +0800 (CST)
Date: Tue, 3 Feb 2026 17:42:29 +0800 (CST)
From: "jempty.liang" <imntjempty@163.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Fix funcgraph_exit calltime/rettime offset
 for 32-bit ARM
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260202103804.40cbaa27@gandalf.local.home>
References: <20260202123342.2544795-1-imntjempty@163.com>
 <20260202103804.40cbaa27@gandalf.local.home>
X-NTES-SC: AL_Qu2cAv2avk8v7yKdZukZn08Ug+s6W8u4vfUi34UbSuccuz/16jA/Y1xiPXvV+t+zIiuesieLSTNuwPt/VKg0Qp3bOChhXkM5jd7NF2MA
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6d66a304.7c37.19c22e1cc92.Coremail.imntjempty@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kCgvCgD3fwwFw4FpxdZjAA--.20764W
X-CM-SenderInfo: hlpq3yxhps35i6rwjhhfrp/xtbC+AWsrWmBwwWWpAAA3g
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wMi0wMiAyMzozODowNCwgIlN0ZXZlbiBSb3N0ZWR0IiA8cm9zdGVkdEBnb29kbWlz
Lm9yZz4gd3JvdGU6Cj5PbiBNb24sICAyIEZlYiAyMDI2IDEyOjMzOjQyICswMDAwCj4iamVtcHR5
LmxpYW5nIiA8aW1udGplbXB0eUAxNjMuY29tPiB3cm90ZToKPgo+PiBDb21taXQgPDY2NjExYzA0
NzU3MDk2MDdmMzk4ZTJhNWQ2OTFiMWZjNzJmZTlkZmM+Cj4+ICAgICAoZmdyYXBoOiBSZW1vdmUg
Y2FsbHRpbWUgYW5kIHJldHRpbWUgZnJvbSBnZW5lcmljKQo+PiBpbmNvcnJlY3RseSBtb2RpZmll
ZCB0aGUgb2Zmc2V0IHZhbHVlcyBmb3IgY2FsbHRpbWUgYW5kIHJldHRpbWUgZmllbGRzCj4+IGlu
IHRoZSBmdW5jZ3JhcGhfZXhpdCB0cmFjZWV2ZW50IG9uIDMyLWJpdCBBUk0sIHdoaWNoIGFyZSB1
c2VkIHRvIHBhcnNlCj4+IHRoZSBjb3JyZXNwb25kaW5nIHZhbHVlcyBmcm9tdHJhY2UgcmF3ZGF0
YS4gVGhlIGFjdHVhbCBtZW1vcnkgb2Zmc2V0IG9mCj4+IGNhbGx0aW1lIGlzIDIwIChub3QgMjQp
LCBhbmQgcmV0dGltZSBpcyAyOCAobm90IDMyKSBmb3IgdGhlIAo+PiBmdW5jZ3JhcGhfZXhpdCBl
dmVudC4KPgo+T0ssIHNvIHRoaXMgaXMgYSAzMmJpdCBpc3N1ZSBhbmQgbm90IGFuIEFSTSBvbmUu
IEkgd2FzIGFibGUgdG8gcmVwcm9kdWNlIGl0Cj5vbiAzMmJpdCB4ODYgdG9vLgo+Cj5CYXNpY2Fs
bHkgdGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgc3RydWN0dXJlIHVzZWQgdG8gb3V0cHV0IHRoZSBm
aWVsZCBvZmZzZXQKPmlzIG91dCBvZiBzeW5jIHdpdGggdGhlIGFjdHVhbCBmaWVsZHMgb2YgdGhl
IHN0cnVjdHVyZS4KPgo+PiAKPj4gQmVmb3JlIHRoZSBmaXgsdGhlIGZ1bmNncmFwaF9leGl0IGZv
cm1hdCB3YXM6Cj4+IAo+PiB+IyBjYXQgL3N5cy9rZXJuZWwvdHJhY2luZy9ldmVudHMvZnRyYWNl
L2Z1bmNncmFwaF9leGl0L2Zvcm1hdAo+PiAKPj4gbmFtZTogZnVuY2dyYXBoX2V4aXQKPj4gSUQ6
IDEwCj4+IGZvcm1hdDoKPj4gICAgIC4uLgo+PiAgICAgZmllbGQ6dW5zaWduZWQgbG9uZyBsb25n
IGNhbGx0aW1lOyBvZmZzZXQ6MjQ7IHNpemU6ODsgc2lnbmVkOjA7Cj4+ICAgICBmaWVsZDp1bnNp
Z25lZCBsb25nIGxvbmcgcmV0dGltZTsgb2Zmc2V0OjMyOyBzaXplOjg7IHNpZ25lZDowOwo+PiAK
Pj4gQWZ0ZXIgdGhlIGZpeCwgdGhlIGNvcnJlY3QgZnVuY2dyYXBoX2V4aXQgZm9ybWF0IGlzOgo+
PiAKPj4gbmFtZTogZnVuY2dyYXBoX2V4aXQKPj4gSUQ6IDEwCj4+IGZvcm1hdDoKPj4gICAgIC4u
Lgo+PiAgICAgZmllbGQ6dW5zaWduZWQgbG9uZyBsb25nIGNhbGx0aW1lOyBvZmZzZXQ6MjA7IHNp
emU6ODsgc2lnbmVkOjA7Cj4+ICAgICBmaWVsZDp1bnNpZ25lZCBsb25nIGxvbmcgcmV0dGltZTsg
b2Zmc2V0OjI4OyBzaXplOjg7IHNpZ25lZDowOwo+PiAKPgo+VGh1cywgdGhlIHdheSB0aGUgY2Fs
bHRpbWUgYW5kIHJldHRpbWUgYXJlIGRlZmluZWQgaXMgdmlhOgo+Cj4KPj4gLS0tIGEva2VybmVs
L3RyYWNlL3RyYWNlX2VudHJpZXMuaAo+PiArKysgYi9rZXJuZWwvdHJhY2UvdHJhY2VfZW50cmll
cy5oCj4+IEBAIC0xMjcsOCArMTI3LDggQEAgRlRSQUNFX0VOVFJZX1BBQ0tFRChmdW5jZ3JhcGhf
ZXhpdCwgZnRyYWNlX2dyYXBoX3JldF9lbnRyeSwKPj4gIAkJX19maWVsZF9wYWNrZWQoCXVuc2ln
bmVkIGxvbmcsCXJldCwJCXJldHZhbAkpCj4+ICAJCV9fZmllbGRfcGFja2VkKAl1bnNpZ25lZCBp
bnQsCXJldCwJCWRlcHRoCSkKPj4gIAkJX19maWVsZF9wYWNrZWQoCXVuc2lnbmVkIGludCwJcmV0
LAkJb3ZlcnJ1bgkpCj4+IC0JCV9fZmllbGQodW5zaWduZWQgbG9uZyBsb25nLAljYWxsdGltZQkJ
KQo+PiAtCQlfX2ZpZWxkKHVuc2lnbmVkIGxvbmcgbG9uZywJcmV0dGltZQkJCSkKPgo+VGhlIF9f
ZmllbGQoKSBtYWNyby4KPgo+PiArCQlfX2ZpZWxkX3BhY2tlZCh1bnNpZ25lZCBsb25nIGxvbmcs
CXJldCwJY2FsbHRpbWUpCj4+ICsJCV9fZmllbGRfcGFja2VkKHVuc2lnbmVkIGxvbmcgbG9uZywJ
cmV0LAlyZXR0aW1lKQo+Cj5Zb3UgY29udmVydGVkIGl0IHRvIGEgX19maWVsZF9wYWNrZWQoKSBt
YWNyby4gVGhlIHJlYXNvbiB0aGlzIHdvcmtlZCBpcwo+YmVjYXVzZSBmaWVsZHMgd2l0aGluIGEg
c3RydWN0dXJlIGRlZmluZWQgYnkgX19maWVsZF9wYWNrZWQoKSBoYXMgYW4KPmFsaWdubWVudCBv
ZiAiMSIgdG8gcGFjayBpdC4KPgo+VGh1cywgeW91ciAiZml4IiBpcyBzaW1wbHkgaGlkaW5nIHRo
ZSByZWFsIGJ1Zywgd2hpY2ggaXMgdGhhdCB0aGUgYWxpZ25tZW50Cj5hbGdvcml0aG0gaXMgd3Jv
bmcuCj4KPkNhbiB5b3UgdHJ5IHRoaXMgcGF0Y2ggdG8gc2VlIGlmIGl0IGZpeGVzIHRoZSBpc3N1
ZSBmb3IgeW91Pwo+Cj5UaGFua3MsCj4KPi0tIFN0ZXZlCj4KPmRpZmYgLS1naXQgYS9rZXJuZWwv
dHJhY2UvdHJhY2VfZXhwb3J0LmMgYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXhwb3J0LmMKPmluZGV4
IDE2OThmYzIyYWZhMC4uNjhlZjM5Y2YwNzEwIDEwMDY0NAo+LS0tIGEva2VybmVsL3RyYWNlL3Ry
YWNlX2V4cG9ydC5jCj4rKysgYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXhwb3J0LmMKPkBAIC04OCw3
ICs4OCw5IEBAIHN0YXRpYyB2b2lkIF9fYWx3YXlzX3VudXNlZCBfX19fZnRyYWNlX2NoZWNrXyMj
bmFtZSh2b2lkKQkJXAo+ICN1bmRlZiBfX2ZpZWxkX2V4dAo+ICNkZWZpbmUgX19maWVsZF9leHQo
X3R5cGUsIF9pdGVtLCBfZmlsdGVyX3R5cGUpIHsJCQlcCj4gCS50eXBlID0gI190eXBlLCAubmFt
ZSA9ICNfaXRlbSwJCQkJCVwKPi0JLnNpemUgPSBzaXplb2YoX3R5cGUpLCAuYWxpZ24gPSBfX2Fs
aWdub2ZfXyhfdHlwZSksCQlcCj4rCS5zaXplID0gc2l6ZW9mKF90eXBlKSwJCQkJCQlcCj4rCS5h
bGlnbiA9IF9fYWxpZ25vZl9fKF90eXBlKSA+IF9fYWxpZ25vZl9fKGxvbmcpID8gX19hbGlnbm9m
X18obG9uZykgOlwKPisJCV9fYWxpZ25vZl9fKF90eXBlKSwJCQkJCVwKPiAJaXNfc2lnbmVkX3R5
cGUoX3R5cGUpLCAuZmlsdGVyX3R5cGUgPSBfZmlsdGVyX3R5cGUgfSwKPiAKPiAKSXQgd29ya3Mg
b24gdGhlIDMyLWJpdCBBUk0gcGxhdGZvcm0uCg==
