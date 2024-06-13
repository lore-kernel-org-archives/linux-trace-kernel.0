Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC212F386;
	Thu, 13 Jun 2024 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297665; cv=none; b=TvOBMVn7nqv7tItFXaO9YFkzWZMlrogwS2bZ3yiSx2243C6eMSfw4aqchqZZyVvLL5kiCk8aVtJ0w3hYe6P10w5leIPfhPDoVm3p28jhtVmVpikXErHMIbb+GICP5/B8Fg04f6SHwNU3aGgBZI0QwXL497ENYCYVEBY4IAXIA28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297665; c=relaxed/simple;
	bh=5BdX6cDGPoODxUqSnKNWI/VnO58TyV/ciiONlB+1aKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qim8NhbTgxwa4J+YtVcjDnv8Kk4Ea570n5MF4U4sfqShN0fGBOaZo9JppBFIeGz7N/lf0QY0PJRVD/xfq457EAaNxEqw6PdbAFMUUCxqmA7r03Um9eDANJWg++9KaqUK0OS60gck5y7rLIGrxBkhozuCEgJUbWKEIUo+gfZe3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=an27DZ6o; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="an27DZ6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718297664; x=1749833664;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5BdX6cDGPoODxUqSnKNWI/VnO58TyV/ciiONlB+1aKI=;
  b=an27DZ6oNFhjEQJNUl3dL1Z7mDeoFh8YdzeUZWesW27wXbFhHxQMRXPD
   AaP/5iXQft7g8BGjxlODfx5StDIwXyNTbGlk05MACfy3kQrQURFvd9KTD
   70FwMkoJkfHhS2LVwPB0oTFgbmCsdQMvn8DU4V32Tk60KEvcs+jf5dNh5
   c=;
X-IronPort-AV: E=Sophos;i="6.08,235,1712620800"; 
   d="scan'208";a="660498136"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 16:54:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:30626]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.168:2525] with esmtp (Farcaster)
 id cd0d13fa-1550-448d-886b-0b5e7837d3c1; Thu, 13 Jun 2024 16:54:20 +0000 (UTC)
X-Farcaster-Flow-ID: cd0d13fa-1550-448d-886b-0b5e7837d3c1
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 13 Jun 2024 16:54:19 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 13 Jun
 2024 16:54:14 +0000
Message-ID: <b0ed328f-c4e5-4e9b-ae4e-5c60703ab376@amazon.com>
Date: Thu, 13 Jun 2024 18:54:12 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
To: Steven Rostedt <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort
	<vdonnefort@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Daniel
 Bristot de Oliveira" <bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, <suleiman@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>, Youssef Esmat
	<youssefesmat@google.com>, Beau Belgrave <beaub@linux.microsoft.com>,
	"Baoquan He" <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, "Paul E.
 McKenney" <paulmck@kernel.org>, David Howells <dhowells@redhat.com>, Mike
 Rapoport <rppt@kernel.org>
References: <20240613155506.811013916@goodmis.org>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240613155506.811013916@goodmis.org>
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGV5IFN0ZXZlLAoKT24gMTMuMDYuMjQgMTc6NTUsIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOgo+IFJl
c2VydmUgdW5zcGVjaWZpZWQgbG9jYXRpb24gb2YgcGh5c2ljYWwgbWVtb3J5IGZyb20ga2VybmVs
IGNvbW1hbmQgbGluZQo+Cj4gQmFja2dyb3VuZDoKPgo+IEluIENocm9tZU9TLCB3ZSBoYXZlIDEg
TUIgb2YgcHN0b3JlIHJhbW9vcHMgcmVzZXJ2ZWQgc28gdGhhdCB3ZSBjYW4gZXh0cmFjdAo+IGRt
ZXNnIG91dHB1dCBhbmQgc29tZSBvdGhlciBpbmZvcm1hdGlvbiB3aGVuIGEgY3Jhc2ggaGFwcGVu
cyBpbiB0aGUgZmllbGQuCj4gKFRoaXMgaXMgb25seSBkb25lIHdoZW4gdGhlIHVzZXIgc2VsZWN0
cyAiQWxsb3cgR29vZ2xlIHRvIGNvbGxlY3QgZGF0YSBmb3IKPiAgIGltcHJvdmluZyB0aGUgc3lz
dGVtIikuIEJ1dCB0aGVyZSBhcmUgY2FzZXMgd2hlbiB0aGVyZSdzIGEgYnVnIHRoYXQKPiByZXF1
aXJlcyBtb3JlIGRhdGEgdG8gYmUgcmV0cmlldmVkIHRvIGZpZ3VyZSBvdXQgd2hhdCBpcyBoYXBw
ZW5pbmcuIFdlIHdvdWxkCj4gbGlrZSB0byBpbmNyZWFzZSB0aGUgcHN0b3JlIHNpemUsIGVpdGhl
ciB0ZW1wb3JhcmlseSwgb3IgbWF5YmUgZXZlbgo+IHBlcm1hbmVudGx5LiBUaGUgcHN0b3JlIG9u
IHRoZXNlIGRldmljZXMgYXJlIGF0IGEgZml4ZWQgbG9jYXRpb24gaW4gUkFNIChhcwo+IHRoZSBS
QU0gaXMgbm90IGNsZWFyZWQgb24gc29mdCByZWJvb3RzIG5vciBjcmFzaGVzKS4gVGhlIGxvY2F0
aW9uIGlzIGNob3Nlbgo+IGJ5IHRoZSBCSU9TIChjb3JlYm9vdCkgYW5kIHBhc3NlZCB0byB0aGUg
a2VybmVsIHZpYSBBQ1BJIHRhYmxlcyBvbiB4ODYuCj4gVGhlcmUncyBhIGRyaXZlciB0aGF0IHF1
ZXJpZXMgZm9yIHRoaXMgdG8gaW5pdGlhbGl6ZSB0aGUgcHN0b3JlIGZvcgo+IENocm9tZU9TOgo+
Cj4gICAgU2VlIGRyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Nocm9tZW9zX3BzdG9yZS5jCj4KPiBQ
cm9ibGVtOgo+Cj4gVGhlIHByb2JsZW0gaXMgdGhhdCwgZXZlbiB0aG91Z2ggdGhlcmUncyBhIHBy
b2Nlc3MgdG8gY2hhbmdlIHRoZSBrZXJuZWwgb24KPiB0aGVzZSBzeXN0ZW1zLCBhbmQgaXMgZG9u
ZSByZWd1bGFybHkgdG8gaW5zdGFsbCB1cGRhdGVzLCB0aGUgZmlybXdhcmUgaXMKPiB1cGRhdGVk
IG11Y2ggbGVzcyBmcmVxdWVudGx5LiBDaG9vc2luZyB0aGUgcGxhY2UgaW4gUkFNIGFsc28gdGFr
ZXMgc3BlY2lhbAo+IGNhcmUsIGFuZCBtYXkgYmUgaW4gYSBkaWZmZXJlbnQgYWRkcmVzcyBmb3Ig
ZGlmZmVyZW50IGJvYXJkcy4gVXBkYXRpbmcgdGhlCj4gc2l6ZSB2aWEgZmlybXdhcmUgaXMgYSBs
YXJnZSBlZmZvcnQgYW5kIG5vdCBzb21ldGhpbmcgdGhhdCBtYW55IGFyZSB3aWxsaW5nCj4gdG8g
ZG8gZm9yIGEgdGVtcG9yYXJ5IHBzdG9yZSBzaXplIGNoYW5nZS4KCgooc29ycnkgZm9yIG5vdCBj
b21tZW50aW5nIG9uIGVhcmxpZXIgdmVyc2lvbnMsIEkgZGlkbid0IHNlZSB2MS12NSBpbiBteSAK
aW5ib3gpCgpEbyB5b3UgaGF2ZSBhICJyZWFsIiBwc3RvcmUgb24gdGhlc2Ugc3lzdGVtcyB0aGF0
IHlvdSBjb3VsZCBzdG9yZSAKbm9uLXZvbGF0aWxlIHZhcmlhYmxlcyBpbiwgc3VjaCBhcyBwZXJz
aXN0ZW50IFVFRkkgdmFyaWFibGVzPyBJZiBzbywgeW91IApjb3VsZCBjcmVhdGUgYW4gYWN0dWFs
bHkgcGVyc2lzdGVudCBtYXBwaW5nIGZvciB5b3VyIHRyYWNlIHBzdG9yZSBldmVuIAphY3Jvc3Mg
a2VybmVsIHZlcnNpb24gdXBkYXRlcyBhcyBhIGdlbmVyYWwgbWVjaGFuaXNtIHRvIGNyZWF0ZSBy
ZXNlcnZlZCAKbWVtYmxvY2tzIGF0IGZpeGVkIG9mZnNldHMuCgoKPiBSZXF1aXJlbWVudDoKPgo+
IE5lZWQgYSB3YXkgdG8gcmVzZXJ2ZSBtZW1vcnkgdGhhdCB3aWxsIGJlIGF0IGEgY29uc2lzdGVu
dCBsb2NhdGlvbiBmb3IKPiBldmVyeSBib290LCBpZiB0aGUga2VybmVsIGFuZCBzeXN0ZW0gYXJl
IHRoZSBzYW1lLiBEb2VzIG5vdCBuZWVkIHRvIHdvcmsKPiBpZiByZWJvb3RpbmcgdG8gYSBkaWZm
ZXJlbnQga2VybmVsLCBvciBpZiB0aGUgc3lzdGVtIGNhbiBjaGFuZ2UgdGhlCj4gbWVtb3J5IGxh
eW91dCBiZXR3ZWVuIGJvb3RzLgo+Cj4gVGhlIHJlc2VydmVkIG1lbW9yeSBjYW4gbm90IGJlIGFu
IGhhcmQgY29kZWQgYWRkcmVzcywgYXMgdGhlIHNhbWUga2VybmVsIC8KPiBjb21tYW5kIGxpbmUg
bmVlZHMgdG8gcnVuIG9uIHNldmVyYWwgZGlmZmVyZW50IG1hY2hpbmVzLiBUaGUgcGlja2VkIG1l
bW9yeQo+IHJlc2VydmF0aW9uIGp1c3QgbmVlZHMgdG8gYmUgdGhlIHNhbWUgZm9yIGEgZ2l2ZW4g
bWFjaGluZSwgYnV0IG1heSBiZQoKCldpdGggS0FTTFIgaXMgZW5hYmxlZCwgZG9lc24ndCB0aGlz
IGFwcHJvYWNoIGJyZWFrIHRvbyBvZnRlbiB0byBiZSAKcmVsaWFibGUgZW5vdWdoIGZvciB0aGUg
ZGF0YSB5b3Ugd2FudCB0byBleHRyYWN0PwoKUGlja2luZyB1cCB0aGUgaWRlYSBhYm92ZSwgd2l0
aCBhIHBlcnNpc3RlbnQgdmFyaWFibGUgd2UgY291bGQgZXZlbiBtYWtlIApLQVNMUiBhdm9pZCB0
aGF0IHJlc2VydmVkIHBzdG9yZSByZWdpb24gaW4gaXRzIHNlYXJjaCBmb3IgYSB2aWFibGUgS0FT
TFIgCm9mZnNldC4KCgpBbGV4CgoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENl
bnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNm
dWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4g
YW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJl
cmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==

