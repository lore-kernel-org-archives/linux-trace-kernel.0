Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D869D31;
	Mon, 17 Jun 2024 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608090; cv=none; b=HMZUhZzdkJHMqP8NGfSyGFklb9Nhj4Bhq/+deSrFkPqaFDkF/0azYhSvTUbQ0XZbosk18NiPEUvX+FQNVoKBMEvUFJH9QVtUdLLm85D1t0V0dqA/YmRw7pDLccc1yCrwklpPqqCWQ0FphWCINyNnip1pLL1+OqrgSNs8aDpbcO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608090; c=relaxed/simple;
	bh=w8HeAcyEUauFysd/D5UhWyakbWbHWE0FzlL+RQtQH5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lJAZw1ivE/Zm4t7BhqRJQClSd62k+4HAI8vIdciOh+Qj8Pl2MxDvsalO48eYtkmGLG/kGbDyqv/UN7n8HOGGIo2f8aZDiTcV0sh90eaVmMc8g+YxovFxOGuunxm0W4GGjSqlMpSgG8DhjCxsRM+3a3KQSfQwwO4ZZrGuCjcxOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fwR6Jvao; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fwR6Jvao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718608089; x=1750144089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w8HeAcyEUauFysd/D5UhWyakbWbHWE0FzlL+RQtQH5k=;
  b=fwR6JvaoDE2JBCdosG33FgT+mB8DpLspuHm0EzX3kjQeSOZ2QeBNSlka
   /uBUPlfv4pCGT5xIAk5mVQyxCq1cgKHwuf+WL/r2fdkFoYAcBz69b3dpZ
   7JYKnC/O3MgNrgiNNKvGBQxP6igjvCo6NuQ3BlRIRLa01jHMwcJaRLQCN
   U=;
X-IronPort-AV: E=Sophos;i="6.08,244,1712620800"; 
   d="scan'208";a="733325863"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 07:07:45 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:4992]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.16:2525] with esmtp (Farcaster)
 id c0d1a6c4-19f9-405c-b3d0-38b92c177528; Mon, 17 Jun 2024 07:07:44 +0000 (UTC)
X-Farcaster-Flow-ID: c0d1a6c4-19f9-405c-b3d0-38b92c177528
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 17 Jun 2024 07:07:36 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 17 Jun
 2024 07:07:31 +0000
Message-ID: <7c90c574-5cfa-40cf-bd4c-1188136cd886@amazon.com>
Date: Mon, 17 Jun 2024 09:07:29 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
To: Steven Rostedt <rostedt@goodmis.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
	<akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>, "Joel
 Fernandes" <joel@joelfernandes.org>, Daniel Bristot de Oliveira
	<bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, <suleiman@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>, Youssef Esmat
	<youssefesmat@google.com>, Beau Belgrave <beaub@linux.microsoft.com>,
	"Baoquan He" <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, "Paul E.
 McKenney" <paulmck@kernel.org>, David Howells <dhowells@redhat.com>, Mike
 Rapoport <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
References: <20240613155506.811013916@goodmis.org>
 <b0ed328f-c4e5-4e9b-ae4e-5c60703ab376@amazon.com>
 <20240613131212.7d1a7ffa@rorschach.local.home>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240613131212.7d1a7ffa@rorschach.local.home>
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGV5IFN0ZXZlLAoKT24gMTMuMDYuMjQgMTk6MTIsIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOgo+IE9u
IFRodSwgMTMgSnVuIDIwMjQgMTg6NTQ6MTIgKzAyMDAKPiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBh
bWF6b24uY29tPiB3cm90ZToKPgo+PiBEbyB5b3UgaGF2ZSBhICJyZWFsIiBwc3RvcmUgb24gdGhl
c2Ugc3lzdGVtcyB0aGF0IHlvdSBjb3VsZCBzdG9yZQo+PiBub24tdm9sYXRpbGUgdmFyaWFibGVz
IGluLCBzdWNoIGFzIHBlcnNpc3RlbnQgVUVGSSB2YXJpYWJsZXM/IElmIHNvLCB5b3UKPj4gY291
bGQgY3JlYXRlIGFuIGFjdHVhbGx5IHBlcnNpc3RlbnQgbWFwcGluZyBmb3IgeW91ciB0cmFjZSBw
c3RvcmUgZXZlbgo+PiBhY3Jvc3Mga2VybmVsIHZlcnNpb24gdXBkYXRlcyBhcyBhIGdlbmVyYWwg
bWVjaGFuaXNtIHRvIGNyZWF0ZSByZXNlcnZlZAo+PiBtZW1ibG9ja3MgYXQgZml4ZWQgb2Zmc2V0
cy4KPiBBZnRlciBpbXBsZW1lbnRpbmcgYWxsIHRoaXMsIEkgZG9uJ3QgdGhpbmsgSSBjYW4gdXNl
IHBzdG9yZSBmb3IgbXkKPiBwdXJwb3NlLiBwc3RvcmUgaXMgYSBnZW5lcmljIGludGVyZmFjZSBm
b3IgcGVyc2lzdGVudCBzdG9yYWdlLCBhbmQKPiByZXF1aXJlcyBhbiBpbnRlcmZhY2UgdG8gYWNj
ZXNzIGl0LiBGcm9tIHdoYXQgSSB1bmRlcnN0YW5kLCBpdCdzIG5vdAo+IHRoZSBwbGFjZSB0byBq
dXN0IGFzayBmb3IgYW4gYXJlYSBvZiBSQU0uCj4KPiBGb3IgdGhpcywgSSBoYXZlIGEgc2luZ2xl
IHBhdGNoIHRoYXQgYWxsb3dzIHRoZSB0cmFjaW5nIGluc3RhbmNlIHRvIHVzZQo+IGFuIGFyZWEg
cmVzZXJ2ZWQgYnkgcmVzZXJ2ZV9tZW0uCj4KPiAgICByZXNlcnZlX21lbT0xMk06NDA5Njp0cmFj
ZSB0cmFjZV9pbnN0YW5jZT1ib290X21hcHBlZEB0cmFjZQo+Cj4gSSd2ZSBhbHJlYWR5IHRlc3Rl
ZCB0aGlzIG9uIHFlbXUgYW5kIGEgY291cGxlIG9mIGNocm9tZWJvb2tzLiBJdCB3b3Jrcwo+IHdl
bGwuCgoKSSBiZWxpZXZlIHdlJ3JlIHRhbGtpbmcgYWJvdXQgMiBkaWZmZXJlbnQgdGhpbmdzIDop
LiBMZXQgbWUgcmVwaHJhc2UgYSAKYml0IGFuZCBtYWtlIGEgY29uY3JldGUgZXhhbXBsZS4KCklt
YWdpbmUgeW91IGhhdmUgcGFzc2VkIHRoZSAicmVzZXJ2ZV9tZW09MTJNOjQwOTY6dHJhY2UiIGtl
cm5lbCBjb21tYW5kIApsaW5lIG9wdGlvbi4gVGhlIGtlcm5lbCBub3cgY29tZXMgdXAgYW5kIGFs
bG9jYXRlcyBhIHJhbmRvbSBjaHVuayBvZiAKbWVtb3J5IHRoYXQgLSBieSAoYWRtaXR0ZWRseSBn
b29kKSBjaGFuY2UgLSBtYXkgYmUgYXQgdGhlIHNhbWUgcGh5c2ljYWwgCmxvY2F0aW9uIGFzIGJl
Zm9yZS4gTGV0J3MgYXNzdW1lIGl0IGRlZW1lZCAweDEwMDAwMDAgYXMgYSBnb29kIG9mZnNldC4K
CkxldCdzIG5vdyBhc3N1bWUgeW91J3JlIHJ1bm5pbmcgb24gYSBVRUZJIHN5c3RlbS4gVGhlcmUs
IHlvdSBhbHdheXMgaGF2ZSAKbm9uLXZvbGF0aWxlIHN0b3JhZ2UgYXZhaWxhYmxlIHRvIHlvdSBl
dmVuIGluIHRoZSBwcmUtYm9vdCBwaGFzZS4gVGhhdCAKbWVhbnMgdGhlIGtlcm5lbCBjb3VsZCBj
cmVhdGUgYSBVRUZJIHZhcmlhYmxlIHRoYXQgc2F5cyAiMTJNOjQwOTY6dHJhY2UgCi0+IDB4MTAw
MDAwMCIuIFRoZSBwcmUtYm9vdCBwaGFzZSB0YWtlcyBhbGwgdGhlc2UgVUVGSSB2YXJpYWJsZXMg
YW5kIAptYXJrcyB0aGVtIGFzIHJlc2VydmVkLiBXaGVuIHlvdSBmaW5hbGx5IHJlYWNoIHlvdXIg
Y29tbWFuZCBsaW5lIHBhcnNpbmcgCmxvZ2ljIGZvciByZXNlcnZlX21lbT0sIHlvdSBjYW4gZmxp
cCBhbGwgcmVzZXJ2YXRpb25zIHRoYXQgd2VyZSBub3Qgb24gCnRoZSBjb21tYW5kIGxpbmUgYmFj
ayB0byBub3JtYWwgbWVtb3J5LgoKVGhhdCB3YXkgeW91IGhhdmUgcHJldHR5IG11Y2ggZ3VhcmFu
dGVlZCBwZXJzaXN0ZW50IG1lbW9yeSByZWdpb25zLCBldmVuIAp3aXRoIEtBU0xSIGNoYW5naW5n
IHlvdXIgbWVtb3J5IGxheW91dCBhY3Jvc3MgYm9vdHMuCgpUaGUgbmljZSB0aGluZyBpcyB0aGF0
IHRoZSBhYm92ZSBpcyBhbiBleHRlbnNpb24gb2Ygd2hhdCB5b3UndmUgYWxyZWFkeSAKYnVpbHQ6
IFN5c3RlbXMgd2l0aCBVRUZJIHNpbXBseSBnZXQgYmV0dGVyIGd1YXJhbnRlZXMgdGhhdCB0aGVp
ciByZWdpb25zIApwZXJzaXN0LgoKCj4KPj4KPj4+IFJlcXVpcmVtZW50Ogo+Pj4KPj4+IE5lZWQg
YSB3YXkgdG8gcmVzZXJ2ZSBtZW1vcnkgdGhhdCB3aWxsIGJlIGF0IGEgY29uc2lzdGVudCBsb2Nh
dGlvbiBmb3IKPj4+IGV2ZXJ5IGJvb3QsIGlmIHRoZSBrZXJuZWwgYW5kIHN5c3RlbSBhcmUgdGhl
IHNhbWUuIERvZXMgbm90IG5lZWQgdG8gd29yawo+Pj4gaWYgcmVib290aW5nIHRvIGEgZGlmZmVy
ZW50IGtlcm5lbCwgb3IgaWYgdGhlIHN5c3RlbSBjYW4gY2hhbmdlIHRoZQo+Pj4gbWVtb3J5IGxh
eW91dCBiZXR3ZWVuIGJvb3RzLgo+Pj4KPj4+IFRoZSByZXNlcnZlZCBtZW1vcnkgY2FuIG5vdCBi
ZSBhbiBoYXJkIGNvZGVkIGFkZHJlc3MsIGFzIHRoZSBzYW1lIGtlcm5lbCAvCj4+PiBjb21tYW5k
IGxpbmUgbmVlZHMgdG8gcnVuIG9uIHNldmVyYWwgZGlmZmVyZW50IG1hY2hpbmVzLiBUaGUgcGlj
a2VkIG1lbW9yeQo+Pj4gcmVzZXJ2YXRpb24ganVzdCBuZWVkcyB0byBiZSB0aGUgc2FtZSBmb3Ig
YSBnaXZlbiBtYWNoaW5lLCBidXQgbWF5IGJlCj4+Cj4+IFdpdGggS0FTTFIgaXMgZW5hYmxlZCwg
ZG9lc24ndCB0aGlzIGFwcHJvYWNoIGJyZWFrIHRvbyBvZnRlbiB0byBiZQo+PiByZWxpYWJsZSBl
bm91Z2ggZm9yIHRoZSBkYXRhIHlvdSB3YW50IHRvIGV4dHJhY3Q/Cj4+Cj4+IFBpY2tpbmcgdXAg
dGhlIGlkZWEgYWJvdmUsIHdpdGggYSBwZXJzaXN0ZW50IHZhcmlhYmxlIHdlIGNvdWxkIGV2ZW4g
bWFrZQo+PiBLQVNMUiBhdm9pZCB0aGF0IHJlc2VydmVkIHBzdG9yZSByZWdpb24gaW4gaXRzIHNl
YXJjaCBmb3IgYSB2aWFibGUgS0FTTFIKPj4gb2Zmc2V0Lgo+IEkgdGhpbmsgSSB3YXMgaGl0IGJ5
IGl0IG9uY2UgaW4gYWxsIG15IHRlc3RpbmcuIEZvciBvdXIgdXNlIGNhc2UsIHRoZQo+IGZldyB0
aW1lcyBpdCBmYWlscyB0byBtYXAgaXMgbm90IGdvaW5nIHRvIGFmZmVjdCB3aGF0IHdlIG5lZWQg
dGhpcyBmb3IKPiBhdCBhbGwuCgoKT25jZSBpcyBwcmV0dHkgZ29vZC4gRG8geW91IGtub3cgd2h5
PyBBbHNvIG9uY2Ugb3V0IG9mIGhvdyBtYW55IHJ1bnM/IElzIAp0aGUgcmFuZG9tbmVzcyBzb3Vy
Y2Ugbm90IGFzIHJhbmRvbSBhcyBpdCBzaG91bGQgYmUgb3IgYXJlIHRoZSBudW1iZXIgb2YgCmJp
dHMgZm9yIEtBU0xSIG1heWJlIHNvIGZldyBvbiB5b3VyIHRhcmdldCBhcmNoaXRlY3R1cmUgdGhh
dCB0aGUgb2RkcyBvZiAKaGl0dGluZyBhbnl0aGluZyBiZWNvbWUgbG93PyBEbyB0aGVzZSBzYW1l
IGNvbnN0cmFpbnRzIGhvbGQgdHJ1ZSBvdXRzaWRlIApvZiB5b3VyIHRlc3RpbmcgZW52aXJvbm1l
bnQ/CgoKQWxleAoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2Vy
bWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6
IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNn
ZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0
LUlEOiBERSAzNjUgNTM4IDU5Nwo=

