Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C13BCD3B;
	Tue, 11 Aug 2026 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430420; cv=none; b=PwylbCw2pBl7Nyr9sV0UlMI6T6jBT9OnKVdKXB7yRI5QP68XBCh0hj3bhMrIM0kju8eYe3M9RmtrgXToYljaqqHE7X6QCtOMvYG9Coh+r9q/g856qwhYtKEQ5RSZJDYAdK91QYvt60GEiUYzeEV0f4NoNqe95RWgiUKeUkEIjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430420; c=relaxed/simple;
	bh=zpn9Q6wCbwmAi1LjmnjfD/IaDhZQ0R7Hf16niZw3nMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VFGjEoDzlRLjUamo9aC0mDjBVMkXIN1ZyEpZ779eiOQ2dY0lEbSBOejJEFVfQhoYKQJ//MugzmBDpc+LieQr13vAou5MjcVapHvmgYS1ohOGb4qlwqq9hi8ar/lAnaPeG+1OYTHK8BlZ8SHMmm5MIiOlhZf2+HhdbcPAqDu8Z2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW001.hihonor.com (unknown [10.77.229.151])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4hK1l66fMXzYl1n1;
	Tue, 11 Aug 2026 14:22:58 +0800 (CST)
Received: from TA008-1.hihonor.com (10.72.0.148) by TW001.hihonor.com
 (10.77.229.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 14:22:58 +0800
Received: from TA008-1.hihonor.com (10.72.0.148) by TA008-1.hihonor.com
 (10.72.0.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 14:22:58 +0800
Received: from TA008-1.hihonor.com ([fe80::e1cf:9270:9b1f:2b7]) by
 TA008-1.hihonor.com ([fe80::e1cf:9270:9b1f:2b7%17]) with mapi id
 15.02.2562.045; Tue, 11 Aug 2026 14:22:58 +0800
From: gao xu <gaoxu2@honor.com>
To: Steven Rostedt <rostedt@goodmis.org>, "Lorenzo Stoakes (ARM)"
	<ljs@kernel.org>
CC: "David Hildenbrand (Arm)" <david@kernel.org>, Xiang Gao
	<gxxa03070307@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, "liam@infradead.org" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Xiang Gao <gaoxiang17@xiaomi.com>
Subject: RE: [PATCH] tracing: report buffer memory in /proc/meminfo
Thread-Topic: [PATCH] tracing: report buffer memory in /proc/meminfo
Thread-Index: AQHdKKxQUSjNT0U+CkilnXunKM92XraWlUIAgAAIaICAADvrAIABWdpw
Date: Tue, 11 Aug 2026 06:22:58 +0000
Message-ID: <9bd98f51abd44d81a569d95e907070c6@honor.com>
References: <20260810094025.136705-1-gaoxiang17@xiaomi.com>
	<69df3080-a719-4131-a247-62bf47bda8a6@kernel.org>	<anm0SMuVpBz7wLac@lucifer>
 <20260810105710.6ee5e493@gandalf.local.home>
In-Reply-To: <20260810105710.6ee5e493@gandalf.local.home>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBPbiBNb24sIDEwIEF1ZyAyMDI2IDEyOjIyOjQzICswMTAwDQo+ICJMb3JlbnpvIFN0b2FrZXMg
KEFSTSkiIDxsanNAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiA+IE9uIE1vbiwgQXVnIDEwLCAy
MDI2IGF0IDEyOjUyOjM4UE0gKzAyMDAsIERhdmlkIEhpbGRlbmJyYW5kIChBcm0pIHdyb3RlOg0K
PiA+ID4gT24gOC8xMC8yNiAxMTo0MCwgWGlhbmcgR2FvIHdyb3RlOg0KPiA+ID4gPiBSZXBvcnQg
dGhlIGRhdGEgY2FwYWNpdHkgb2YgYWxsIGZ0cmFjZSByaW5nIGJ1ZmZlcnMgdGhyb3VnaCBhIG5l
dw0KPiA+ID4gPiBGdHJhY2UgZmllbGQgaW4gL3Byb2MvbWVtaW5mby4gSW5jbHVkZSB0aGUgbWFp
biBhbmQgc25hcHNob3QNCj4gPiA+ID4gYnVmZmVycyBvZiB0aGUgZ2xvYmFsIHRyYWNlIGFycmF5
IGFuZCBhbGwgdHJhY2luZyBpbnN0YW5jZXMsIHdoaWxlDQo+ID4gPiA+IGxlYXZpbmcgcmluZy1i
dWZmZXIgbWV0YWRhdGEgYWNjb3VudGVkIGZvciBieSBTbGFiLg0KPiA+ID4NCj4gPiA+IHdoeT8g
OikNCj4gPiA+DQo+ID4gPiBUbyByZXBvcnQgYSBoYW5kZnVsIG9mIEtpQiBhcyBpbiB5b3VyIGV4
YW1wbGUgYmVsb3c/IERvZXNuJ3Qgc291bmQNCj4gPiA+IHN1cGVyIGhlbHBmdWwgVEJILg0KPiA+
DQo+ID4gWWVhaCBJIHRoaW5rIHdlIG5lZWQgdG8gc3RvcCB3aXRoIGFsbCB0aGUgcHJvcG9zZWQg
YWRkaXRpb25zIHRvDQo+ID4gL3Byb2MvbWVtaW5mbyA6KQ0KPiA+DQo+ID4gQWxzbyBzb21ldGhp
bmcgbGlrZSB0aGlzIHdoZXJlIHlvdSBhcmUgbWFraW5nIGEgY2hhbmdlIGluIG91dHB1dCB0aGF0
DQo+ID4gaXQgaXMganVzdCB5b3VyIG9waW5pb24gdGhhdCBpdCBpcyB1c2VmdWwgc2hvdWxkIGJl
IGFuIFJGQyB0byBzZWUgd2hhdA0KPiA+IHRoZSBjb21tdW5pdHkgdGhpbmtzIGZpcnN0Lg0KPiAN
Cj4gQWdyZWVkLiBUaGlzIGRvZXNuJ3QgYmVsb25nIGluIHRoZSBtZW1pbmZvLiBJZiB5b3Ugd2Fu
dCBtZW1vcnkgc3RhdGlzdGljcyBmb3INCj4gdHJhY2luZywgSSBtYXkgYmUgT0sgaWYgeW91IGFk
ZCBhICJ0b3RhbF9tZW1vcnlfa2IiIGZpbGUgaW4gdGhlDQo+IC9zeXMva2VybmVsL3RyYWNpbmcv
dHJhY2Vfc3RhdHMvIGRpcmVjdG9yeS4NCldvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGluY2x1ZGUg
dGhpcyBpbmZvIGluIHNob3dfbWVtKCk/DQpUaGlzIHdvdWxkIGJlIGhlbHBmdWwgZm9yIGFuYWx5
emluZyBsb3ctbWVtb3J5IGFuZCBPT00gaXNzdWVzLg0KPiANCj4gQW5kIGJyZWFrIGl0IHVwIGZv
ciBtZW1vcnkgdXNlZC4gUmluZyBidWZmZXJzLCBldmVudHMsIGV0Yy4NCj4gDQo+IFBlcmhhcHMg
ZXZlbiBhZGQgb25lIHBlciBDUFUgYXMgd2VsbC4NCj4gDQo+IEknbSBhbHdheXMgY29uc2NpZW5j
ZSBhYm91dCBob3cgbXVjaCBtZW1vcnkgdHJhY2luZyBpcyB0YWtpbmcgdXAgaW4gdGhlDQo+IHN5
c3RlbS4NCj4gDQo+IC0tIFN0ZXZlDQoNCg==
