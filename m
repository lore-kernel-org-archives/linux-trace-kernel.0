Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D412D399003;
	Tue,  3 Feb 2026 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113099; cv=none; b=tkJI6HdrL5US82kJswJ4NivzV7omW8RNmeZ2yLzXMMvAaPzQRs1f6U1971PwKiNV5fc2OvuI1ks0Eriot8v8jrctJpSTG3zC2jtzA4evblwZk3P7dC6XiJPLVmfMIxX9qPJY6JvIFuVi/VIwbgThvxFhMIdlMziK8rEPB6bVpFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113099; c=relaxed/simple;
	bh=4f5wvDrXhqZ9KEW3p7RxALJv6cCBMmLoWQ37Cmb2RLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=FLZTJnDB5rDXRT4Unf7sZiaR4J5bvyR6LQwhFx4i5YOLa/jHK4+WQLSi4SPhVXInG6Nj8tZXsC/lh0GWQpzx1N9I4b5OFUk8y84ASIFR2ma+czcS7wUF5ow/HPzWONaIC+4+NCQW6Wf7+0m3DBQxUTKSJYoDy3q0dGoNRkvHkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fI+BeFWQ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fI+BeFWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=4f5wvDrXhqZ9KEW3p7RxALJv6cCBMmLoWQ37Cmb2RLY=; b=f
	I+BeFWQoxmasS/3ah/0iGVxPDDl4hAk+eprqoaUNkZkD08u4OhKONDfcA58HE93F
	y/tqEjCW7nrAV1u191fgQNpVKXQzeREKOZkTYl/sgut0tRqGHa73+GRct3J9kS0P
	R3Lf1VlAjOkCG9Oh5m4q+1l9Z14LAv9prqYpQY8tjI=
Received: from imntjempty$163.com ( [183.47.95.209] ) by
 ajax-webmail-wmsvr-40-144 (Coremail) ; Tue, 3 Feb 2026 18:04:21 +0800 (CST)
Date: Tue, 3 Feb 2026 18:04:21 +0800 (CST)
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
In-Reply-To: <20260202110828.440c8d44@gandalf.local.home>
References: <20260202123342.2544795-1-imntjempty@163.com>
 <20260202103804.40cbaa27@gandalf.local.home>
 <20260202110828.440c8d44@gandalf.local.home>
X-NTES-SC: AL_Qu2cAv2avEgt5yKbZ+kZn08Ug+s6W8u4vfUi34UbSuccuz/16jA/Y1xiPXvV+t+zIiuesieLSTNuwPt/VKizvo2q603Wja0Zd9LaB49J
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <19eab264.7fae.19c22f5d17c.Coremail.imntjempty@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kCgvCgAHQNgmyIFpbdtjAA--.20672W
X-CM-SenderInfo: hlpq3yxhps35i6rwjhhfrp/xtbC+Ab19mmByCb0VAAA3b
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wMi0wMyAwMDowODoyOCwgIlN0ZXZlbiBSb3N0ZWR0IiA8cm9zdGVkdEBnb29kbWlz
Lm9yZz4gd3JvdGU6Cj5PbiBNb24sIDIgRmViIDIwMjYgMTA6Mzg6MDQgLTA1MDAKPlN0ZXZlbiBS
b3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPiB3cm90ZToKPgo+PiBDYW4geW91IHRyeSB0aGlz
IHBhdGNoIHRvIHNlZSBpZiBpdCBmaXhlcyB0aGUgaXNzdWUgZm9yIHlvdT8KPgo+SWdub3JlIHRo
YXQgcGF0Y2gsIHRyeSB0aGlzIG9uZSBpbnN0ZWFkLiBUaGlzIHdhcyBmaXhlZCBmb3IgdHJhY2Vf
ZXZlbnRzIGEKPndoaWxlIGFnbywgYnV0IHRoZSBzYW1lIGZpeCB3YXNuJ3QgZG9uZSBmb3IgZnRy
YWNlIGV2ZW50cy4KPgo+LS0gU3RldmUKPgo+ZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS90cmFj
ZV9leHBvcnQuYyBiL2tlcm5lbC90cmFjZS90cmFjZV9leHBvcnQuYwo+aW5kZXggMTY5OGZjMjJh
ZmEwLi41Yjk2YWM3NTAwNDkgMTAwNjQ0Cj4tLS0gYS9rZXJuZWwvdHJhY2UvdHJhY2VfZXhwb3J0
LmMKPisrKyBiL2tlcm5lbC90cmFjZS90cmFjZV9leHBvcnQuYwo+QEAgLTE0LDYgKzE0LDkgQEAK
PiAKPiAjaW5jbHVkZSAidHJhY2Vfb3V0cHV0LmgiCj4gCj4rLyogVGhlIGFsaWdubWVudCBvZiBh
IHR5cGUgd2hlbiBpbiBhIHN0cnVjdHVyZSAqLwo+KyNkZWZpbmUgQUxJR05fU1RSVUNURklFTEQo
dHlwZSkgKChpbnQpKF9fYWxpZ25vZl9fKHN0cnVjdCB7dHlwZSBiO30pKSkKPisKPiAvKiBTdHVi
IGZ1bmN0aW9uIGZvciBldmVudHMgd2l0aCB0cmlnZ2VycyAqLwo+IHN0YXRpYyBpbnQgZnRyYWNl
X2V2ZW50X3JlZ2lzdGVyKHN0cnVjdCB0cmFjZV9ldmVudF9jYWxsICpjYWxsLAo+IAkJCQkgZW51
bSB0cmFjZV9yZWcgdHlwZSwgdm9pZCAqZGF0YSkKPkBAIC04OCw3ICs5MSw3IEBAIHN0YXRpYyB2
b2lkIF9fYWx3YXlzX3VudXNlZCBfX19fZnRyYWNlX2NoZWNrXyMjbmFtZSh2b2lkKQkJXAo+ICN1
bmRlZiBfX2ZpZWxkX2V4dAo+ICNkZWZpbmUgX19maWVsZF9leHQoX3R5cGUsIF9pdGVtLCBfZmls
dGVyX3R5cGUpIHsJCQlcCj4gCS50eXBlID0gI190eXBlLCAubmFtZSA9ICNfaXRlbSwJCQkJCVwK
Pi0JLnNpemUgPSBzaXplb2YoX3R5cGUpLCAuYWxpZ24gPSBfX2FsaWdub2ZfXyhfdHlwZSksCQlc
Cj4rCS5zaXplID0gc2l6ZW9mKF90eXBlKSwgLmFsaWduID0gQUxJR05fU1RSVUNURklFTEQoX3R5
cGUpLAlcCj4gCWlzX3NpZ25lZF90eXBlKF90eXBlKSwgLmZpbHRlcl90eXBlID0gX2ZpbHRlcl90
eXBlIH0sCj4gCk9uIHRoZSAzMi1iaXQgQVJNIHBsYXRmb3JtLCB3aGVuIF90eXBlIGlzIHVuc2ln
bmVkIGxvbmcgbG9uZywgdGhlIHJlc3VsdGluZyBhbGlnbiB2YWx1ZSBpcyA4IGluc3RlYWQgb2Yg
dGhlIGV4cGVjdGVkIDQuCj4gCg==
