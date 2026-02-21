Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5983C17;
	Sat, 21 Feb 2026 03:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771644394; cv=none; b=fg0ehOeJb5haoa13zrQwesYZlWAHNbgRkG+xUPHthwXtVudexLZz4cmZ+NA9Bl6TfU4p3yiY23qOqXnpFHTw+MfFzcVT13Yul0kB70m1lnJ7I9Hsusjss0nloq9ZECowV3ynCTEcQy0Z4G5hZC+U6kUpHEumjCmAAfNp5Ylz3BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771644394; c=relaxed/simple;
	bh=zwdi1p2l1kFAEawbUQbqj4Q0+6D9nODkCUgRpgbOeEY=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=FKH/6yTGqbn0ZwS4zYAsDKjDZyd1t44KgljOS9e9An/9sk5YtXm1B7rE8IDR0yp1tjFuIdrol1YCyKTeABHViQJNQvMyI+vLAPYErBWOIUY8BW9G6pNrsgzhWuG8hdEfdTA4015N3UEEw/A9bvum86itmKOoZjFAOEsQLNNJzIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fHshz4d0MzW7q;
	Sat, 21 Feb 2026 11:16:35 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4fHshr0nkFz5TCG0;
	Sat, 21 Feb 2026 11:16:28 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fHshf2CvLz5B1KR;
	Sat, 21 Feb 2026 11:16:18 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 61L3GCQD039911;
	Sat, 21 Feb 2026 11:16:12 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 21 Feb 2026 11:16:12 +0800 (CST)
X-Zmail-TransId: 2af96999237c07c-e700d
X-Mailer: Zmail v1.0
Message-ID: <202602211116123227p4Je6QELxr2byqvy9kTE@zte.com.cn>
Date: Sat, 21 Feb 2026 11:16:12 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>
Cc: <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhang.run@zte.com.cn>,
        <yang.tao172@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <hu.shengming@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDAvMl0gZmdyYXBoOiBmaXhlcyBmb3IgdGhyZXNoX3JldHVybiByZXR1cm4gaGFuZGxlcg==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 61L3GCQD039911
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.35.20.165 unknown Sat, 21 Feb 2026 11:16:36 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69992392.000/4fHshz4d0MzW7q



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogU2hlbmdtaW5nIEh1IDxodS5zaGVuZ21pbmdAenRlLmNvbS5jbj4NCg0KSGksDQoNClRo
aXMgc2VyaWVzIGZpeGVzIHR3byBpc3N1ZXMgaW4gdHJhY2VfZ3JhcGhfdGhyZXNoX3JldHVybigp
LCB0aGUgZnVuY3Rpb24NCmdyYXBoIHJldHVybiBoYW5kbGVyIHVzZWQgd2hlbiB0cmFjaW5nX3Ro
cmVzaCBpcyBlbmFibGVkOg0KDQpQQVRDSDE6IENsZWFyIHRoZSBwZXItdGFzayBUUkFDRV9HUkFQ
SF9OT1RSQUNFIHN0YXRlIGxpa2UNCnRyYWNlX2dyYXBoX3JldHVybigpIGRvZXMuDQpQQVRDSDI6
IEF2b2lkIGRvdWJsZSBuby1zbGVlcC10aW1lIGFkanVzdG1lbnQgYnkgZW1pdHRpbmcNCnRoZSBy
ZXR1cm4gZXZlbnQgZGlyZWN0bHkgd2hlbiB0aGUgdGhyZXNob2xkIGlzIG1ldC4NCg0KUGF0Y2gg
ZGV0YWlscyBhcmUgaW4gdGhlIGluZGl2aWR1YWwgY29tbWl0IG1lc3NhZ2VzLg0KDQpTaGVuZ21p
bmcgSHUgKDIpOg0KICBbUEFUQ0ggMS8yXSBmZ3JhcGg6IGZpeCB0aHJlc2hfcmV0dXJuIGNsZWFy
IHBlci10YXNrIG5vdHJhY2UNCiAgW1BBVENIIDIvMl0gZmdyYXBoOiBmaXggdGhyZXNoX3JldHVy
biBub3NsZWVwdGltZSBkb3VibGUtYWRqdXN0DQoNCiBrZXJuZWwvdHJhY2UvdHJhY2VfZnVuY3Rp
b25zX2dyYXBoLmMgfCAxOSArKysrKysrKysrKysrLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yNS4x


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxkaXYgc3R5bGU9ImxpbmUtaGVpZ2h0OjEuNSI+RnJv
bTogU2hlbmdtaW5nIEh1ICZsdDtodS5zaGVuZ21pbmdAenRlLmNvbS5jbiZndDs8L2Rpdj48ZGl2
IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdo
dDoxLjUiPkhpLDwvZGl2PjxkaXYgc3R5bGU9ImxpbmUtaGVpZ2h0OjEuNSI+PGJyPjwvZGl2Pjxk
aXYgc3R5bGU9ImxpbmUtaGVpZ2h0OjEuNSI+VGhpcyBzZXJpZXMgZml4ZXMgdHdvIGlzc3VlcyBp
biB0cmFjZV9ncmFwaF90aHJlc2hfcmV0dXJuKCksIHRoZSBmdW5jdGlvbjwvZGl2PjxkaXYgc3R5
bGU9ImxpbmUtaGVpZ2h0OjEuNSI+Z3JhcGggcmV0dXJuIGhhbmRsZXIgdXNlZCB3aGVuIHRyYWNp
bmdfdGhyZXNoIGlzIGVuYWJsZWQ6PC9kaXY+PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS41Ij48
YnI+PC9kaXY+PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS41Ij5QQVRDSDE6IENsZWFyIHRoZSBw
ZXItdGFzayBUUkFDRV9HUkFQSF9OT1RSQUNFIHN0YXRlIGxpa2U8L2Rpdj48ZGl2IHN0eWxlPSJs
aW5lLWhlaWdodDoxLjUiPnRyYWNlX2dyYXBoX3JldHVybigpIGRvZXMuPC9kaXY+PGRpdiBzdHls
ZT0ibGluZS1oZWlnaHQ6MS41Ij5QQVRDSDI6IEF2b2lkIGRvdWJsZSBuby1zbGVlcC10aW1lIGFk
anVzdG1lbnQgYnkgZW1pdHRpbmc8L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPnRo
ZSByZXR1cm4gZXZlbnQgZGlyZWN0bHkgd2hlbiB0aGUgdGhyZXNob2xkIGlzIG1ldC48L2Rpdj48
ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhl
aWdodDoxLjUiPlBhdGNoIGRldGFpbHMgYXJlIGluIHRoZSBpbmRpdmlkdWFsIGNvbW1pdCBtZXNz
YWdlcy48L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPjxicj48L2Rpdj48ZGl2IHN0
eWxlPSJsaW5lLWhlaWdodDoxLjUiPlNoZW5nbWluZyBIdSAoMik6PC9kaXY+PGRpdiBzdHlsZT0i
bGluZS1oZWlnaHQ6MS41Ij4mbmJzcDsgW1BBVENIIDEvMl0gZmdyYXBoOiBmaXggdGhyZXNoX3Jl
dHVybiBjbGVhciBwZXItdGFzayBub3RyYWNlPC9kaXY+PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6
MS41Ij4mbmJzcDsgW1BBVENIIDIvMl0gZmdyYXBoOiBmaXggdGhyZXNoX3JldHVybiBub3NsZWVw
dGltZSBkb3VibGUtYWRqdXN0PC9kaXY+PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS41Ij48YnI+
PC9kaXY+PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS41Ij4mbmJzcDtrZXJuZWwvdHJhY2UvdHJh
Y2VfZnVuY3Rpb25zX2dyYXBoLmMgfCAxOSArKysrKysrKysrKysrLS0tLS0tPC9kaXY+PGRpdiBz
dHlsZT0ibGluZS1oZWlnaHQ6MS41Ij4mbmJzcDsxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSk8L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPjxi
cj48L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPi0tJm5ic3A7PC9kaXY+PGRpdiBz
dHlsZT0ibGluZS1oZWlnaHQ6MS41Ij4yLjI1LjE8L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdo
dDoxLjUiPjxicj48L2Rpdj48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

