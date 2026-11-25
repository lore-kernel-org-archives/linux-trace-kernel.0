Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573222;
	b=PbonZsJlsQifsk9q2s+vJtjXnRMSvYfxttkvflyakOwxWg/6taW4Zqv59+vRJTySzrAf
	 3AWVyQBPVhA4uMYuJhiEyGRkpy+DtRUtQXPHGG0Qu1fjZxqaU8YV0ce5M/eLVapHDH1Zb
	 4fvmrac89VfkzDlqXvdATyAFbSPbJsPLCjxwoqIcf5Q1jyyISqCJvaynJw4CJi0XZ7eR4
	 QiQCF204gZV4QaIerd/nSL8ef9pbrTSvCZBEhhTkJMgMBD295+ioKVt3P/JLar0YJEHCk
	 Il23GJ23eROw/yX9DY4DF5FmjW2veROpCgNxsu3pcCN7nA/k5rZFx69qRMVHVs3qU0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573222;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=enKPMmqaMAv6kvmuMKSozHDoIEDFjVm3+Lzr77Y2kYY=;
	b=oU4qwM/c3gVw0EA+5xmIySA4Yh8YHRcrModwYTJ1KxZIN68qzpMkhgbB0Et11rKgd3gj
	 tCFDJJQcIux3BmxtgkOamh9ojVRsIH8UDLTHqGH/d+IaViYZwJjiBkOXwaS1z3qii86iA
	 i9zg8cNtjhNb1O7oDfN+g5HNO+yfF/HpTXA7mrvwvDuBQHzpohYA3T4wNOt6fVg1Lp1de
	 CVaA8DrU3Mv7nD5cZRYqE8f5Ai/5uffDCIJh68axKWQgowGQqItNJ0HBolQtYaqOjam0a
	 j3cdxTIZ3A47Ak0VkHxMbgWmFsOQDgv59y3KEapdaNIDyUVWFaQ+83iImDBqvzP/YQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b="a/QGKTCi";
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF2606A31E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 02:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42FF2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=a/QGKTCi
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E002E40DA9;
	Wed, 25 Nov 2026 02:20:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 329842000F;
	Wed, 25 Nov 2026 02:20:14 +0000 (UTC)
Date: Tue, 24 Nov 2026 21:20:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Wenwu Hou" <hwenwur@gmail.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/hwlat: Bind the sampler kthread instead of
 setting its affinity
Message-ID: <20261124212011.5862dca6@robin>
In-Reply-To: <sashiko-outbox-208125@kernel.org>
References: <20261111020755.1422284-1-hwenwur@gmail.com>
	<sashiko-outbox-208125@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Stat-Signature: 9aymca8cnk8gmc8nqkwpauuw7b3ak6w4
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 329842000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+w4dfy2t6tdovpNuDHUYW978Ct6dRYiis=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=enKPMmqaMAv6kvmuMKSozHDoIEDFjVm3+Lzr77Y2kYY=; b=a/QGKTCi/eEncmcduv7rYyuzdEN0a+tTmIztCPy7qJcfukQguLSwlVm+8DbtLa9snfYlLzIMjKuJUnJnAWWxeFcQZzx8YtKJBQzX0wBy1CoZiRQwIEULO1ArN99HwX2WbxHvbmhK4yt6AHeudcOcFe2H1gOxIzF3XmCclyYs8aw=
X-HE-Tag: 1795573214-240266
X-HE-Meta: U2FsdGVkX19Di/CUmryauWIiw3uK/QJ52CfoIVYe5LCfrqBceTm5jXLRC/OR6Qrk+7NEgyyvoWcJ0jlP/E5glsBW8UdtCMT0kP9HKANLoY7uAuWWIW0tckt7F8BsMrKQUBHlZucTB11JL7YVQZ1jMbRfYnQzHT4hLE0hBVfx14H4UV+FufGwb9ZXeiVhy1KMDYtwDG9loCsNbNnwS/PckLUMWixWdw9y7otEHX/cSc8Gl6VGTol+3lnJ6SYNisHMFp6Fu7AoVU8KoRS0i2QOhguG81cBlY0OCNcG4PkHCSEaNhKhfp4Hgc5je+b13YNw5frbYBpP10SITxWXo5jWVYNQi3l3RIwN

On Wed, 11 Nov 2026 02:54:09 +0000
sashiko-bot@kernel.org wrote:

> [Severity: Medium]
> Does leaving PF_NO_SETAFFINITY set on hwlatd prevent userspace from
> changing its CPU affinity or moving it into a cgroup?
> 
> kthread_bind_mask() sets PF_NO_SETAFFINITY, which kthread() only checks on
> initial wake-up before calling kthread_fn().  Because kthread_fn() never
> clears the flag, sched_setaffinity() and cgroup_attach_permissions()
> reject hwlatd with -EINVAL in both round-robin and none modes.  That also
> makes the user-affinity override check in move_to_next_cpu() unreachable
> from sched_setaffinity():
> 
> kernel/trace/trace_hwlat.c:move_to_next_cpu() {
> 	/*
> 	 * If for some reason the user modifies the CPU affinity
> 	 * of this thread, then stop migrating for the duration
> 	 * of the current test.
> 	 */
> 	if (!cpumask_equal(current_mask, current->cpus_ptr))
> 		goto change_mode;
>     ...
> }
> 
> Clearing PF_NO_SETAFFINITY in kthread_fn() once the thread has started, as
> done in 4998e7fda149 ("tracing/osnoise: Switch from PF_NO_SETAFFINITY to
> migrate_disable"), would avoid this regression while still skipping
> kthread_affine_node() on the initial wake-up.

I agree with Sashiko. Please update and send a new version.

Thanks,

-- Steve
