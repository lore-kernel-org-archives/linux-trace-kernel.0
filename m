Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210720;
	b=kk8vWVlZMdKnvq9Kl5MOr3Ht6J0fbkWQNQaXWNyuElN0p16efaq/qowJeS7ySpydaKXD
	 9s3NYUbJ9LHIilCKkHXZqxXUkFEImPxENgVd2dNos3wWYiV/ScfFVZGd/lp+6QPrRctKK
	 WMGcKUt1fGcLbnw2HB+X6IDLYxBkvlniftt4RStsoDyMMyEKgew5RJ+lFj9dpiDsUUcpr
	 StaaWiM1jvfyoB34ANtYRvsab0r5Kdzn1uYCa1nwiBFJV7//YOl3h9ZJiNvnWNgHPMsah
	 Qz2vfkbZQiR/3/QlT3hws2CDF2fGPkMnKwxuM/Hu37cB3v10DAB8Gh7tGUfq7rzRlDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210720;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=wEUOSGCIpQzoTNVTbR0auAYK0KYHBuNLYj/30GCU/js=;
	b=TuOEha8EFdEJsJSpRiwqMu30M3OI1CIrEHgWeHcK3dc++k1bUtBDq0T7MFJRj5Smt+oR
	 b26zSnltvT9qxXX2KCAXqvDkDfcMtUdti/g0ozuqoH4mQmO+B8MgPx8lwxtdBegENqa5e
	 RfEUHYRyE5oR9M4obF5H7A5GjycoI3nFzg5ewHsLDv8gccpfEK0r8ho9VG8lWziIpb65q
	 5knyf3qo3gJQlNnyOK6+XwD5N+uQ8uGSblzm+NxcOkxdhFvx94Od63mORlnqnr9cFxY8F
	 yAD4iQJBv726a1QGL0Cax0L0ctdRGxV36q4CdmjLUceECqGhyXLu2dMkJThpGg4g3kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=QXvzC3R4;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9959606A31A;
	Wed, 28 Oct 2026 18:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9959606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=QXvzC3R4
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 42CB21A01B3;
	Wed, 28 Oct 2026 18:05:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 5EF0D20025;
	Wed, 28 Oct 2026 18:05:16 +0000 (UTC)
Date: Wed, 28 Oct 2026 14:05:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Yury Norov
 <yury.norov@gmail.com>
Subject: Re: [PATCH] lockdep: Add #include <linux/instruction_pointer.h> to
 lockdep.h
Message-ID: <20261028140514.172d70cb@gandalf.local.home>
In-Reply-To: <auI22-Woy8ap8cz-@yury>
References: <20261028110558.623a92d1@gandalf.local.home>
	<auIRtQjGjb0yeYCX@yury>
	<20261028114528.137acd81@gandalf.local.home>
	<auIZQDojrrv43MrA@yury>
	<20261028123051.0c65e19f@gandalf.local.home>
	<auI22-Woy8ap8cz-@yury>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 83eghaxr55671je6uto74zqdbqoi47uq
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 5EF0D20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18rax3BPHg44DaLCe1//TVvutoMf7LmI/8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=wEUOSGCIpQzoTNVTbR0auAYK0KYHBuNLYj/30GCU/js=; b=QXvzC3R4vbahvEfngiRwXtG1y0BrBBj7+zTz+9jLRpEy3we/G9BWcdtbmIBBl6UZWhtKftVMJReLLaYzjwb1fPjqdiHBiJfiP3tkLmWutdXuMCBxoTrkpidmHRshlokGBX6HAmoy/jeCdLPbyfd0i4a3lSs3t8MzwnS62b26Pd8=
X-HE-Tag: 1793210716-141690
X-HE-Meta: U2FsdGVkX18MdYMN6yJ8SRVWkSOAuKuXVoujKfZttUzaPfGYpm/BiEbTQ1ZwfM/aygH0C+1ZM3DW4jkl8Ehfg2p4Re2pVLz/bCYXbjXI/TLsdEqaW8SG5WSwD5yNaenBj1n9CaPR5NoNw1Avuen55/sExxtIKEar5QjJjUub/Uxd41CyGIAGWUKHBqlBPj5FMptpZsYX5HOCx0612Sy1RQRMZzKTpMBuM8QU34UPtM2vMdkctMThjUzgVmKI6hOLkfXOoVPmR4Lv20kWX4bNbZn/ukK87mUUs7+g/kpIfTl4Zw9Eo8ocUv9Ktn0j6K+IcEgOJ2gT7Af3TPdpJuKMr4gvEl2GFdBMbhCUvsbRGAswwok4MsEKzg==

On Wed, 28 Oct 2026 13:54:35 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> Hmm... Seems I overlooked that v4. If not too late, please add my:
> 
> Reviewer-by: Yury Norov <ynorov@nvidia.com>

Sure, no problem. Except I'll put it as:

 Reviewed-by: Yury Norov <ynorov@nvidia.com>

 ;-)

-- Steve

