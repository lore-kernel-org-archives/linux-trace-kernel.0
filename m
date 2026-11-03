Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717430;
	b=h664BkdC4BLBxDYuWPy2GW78Gy+tjtcqQzuZ2ioKihRsrbsK2/2SYZhhhZj1KYtdeYab
	 GeobJYxSa7kzZtDDTEEcDUL/HC6e6kF7DdnGOb9w8ZUnnt/ewwH/LxfizmpCkwoO0PyK6
	 8MI8JTrdy22j8KGJ+4oKzzLDS+RsUFR/ovB2yBPoprW5RanlZbzgQgvTPMGhFmfFPt+0a
	 /XqevlcRSlvrF4WByhM34EhmgS62BhBTxA3+uGuzRBFbCFHfXcYkptcEJUgRoIPWJtwYb
	 yn6gND1BQ1L9UiVADajm+BP6ekUIDR4JdFYg5lcLezuPbn1PLMIEjE+IoK1Ef023HRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717430;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=3KZBN4g8hHRhd5aTLy1dmEYizxY7WtdZWKzgT4zNB+k=;
	b=UG/mFQolDbS0BhTGc6ZfVyszw5AH9TeLogFr2Gid7mASoAdU5kM+b4CTxYPo+Xmflxh4
	 wicFxjWq1iFDvs542yP/ikRelyEu2tmGhH5g6vn44YugVLxM3D7xYmgMcR8tTW/OFT3eg
	 Sw88dUs17ngDXhrwkfMTSy7+N9yrP6ZGzmDPkLX7Aa+8EGs9fejgGyddIc04HvxCaWNjm
	 uHlfj+4JNqBDAweSYOUW1bUvXCa7dfqe9wu1kM7ZyaKVv7EDbTu7zYViR0V5VSguCpFdv
	 RAmInDzRvte1koVIK70u3lvTcGIo4G5i86de1blktAWbTu7xxtwumjvJMDD+8gLzYlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=D12nnsLJ;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC6606D83C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 14:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4BC6606D83C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=D12nnsLJ
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id C368D120285;
	Tue,  3 Nov 2026 14:50:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 1C5EB20024;
	Tue,  3 Nov 2026 14:50:21 +0000 (UTC)
Date: Tue, 3 Nov 2026 09:50:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Jaewon Jung" <jaewon8868@gmail.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Keep copying markers when one instance is
 stopped
Message-ID: <20261103095019.6a88e783@gandalf.local.home>
In-Reply-To: <sashiko-outbox-194417@kernel.org>
References: <20261103005219.3236380-1-jaewon8868@gmail.com>
	<sashiko-outbox-194417@kernel.org>
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
X-Rspamd-Queue-Id: 1C5EB20024
X-Stat-Signature: 7terwbbhgw4rj3d6qmmwwwokauigtmpa
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX186CmU9YsXUeVI7SLF9eisJ+p2TAcKubaI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=3KZBN4g8hHRhd5aTLy1dmEYizxY7WtdZWKzgT4zNB+k=; b=D12nnsLJWW6Sf/FmjqJg8oEBdbzsiLqapgPyIfxQBcfku13C0ND3VV9o/ySaf95RggDsp5vgJNw2jPJh949GMqO9obgOKpAlIb2wqgWKeYbrlIqKLJg9VtVoGhDl8CjKqwUgLUGiFiF1D15rntIq+OAE15qPLah6icuuRa+7dTY=
X-HE-Tag: 1793717421-52474
X-HE-Meta: U2FsdGVkX1/V5AjvAbqQGsbmHxIX4njFY5YwlCgJQ2w0HmiByd2ygSymNw5+I29yScVEMY6JGyyMS0uGZZ3WCoR0yTLG2Pz0mpYXHkUBGdL7v0p2Cw9pMoReuMxOVzaxx8iFDA3ZW8QmcVoFZoZ7ygUfiEyEmAO5e3deii/hUVorY+NvQLFXF8CICKaeD7TpJm+AY1rEkk07P6gaBkpgjKK8pINlaCcrJmq78WiCJ3IhwrJqB8F5JbbzhTIB/ne6gMv2/k5SxPUcJps6mfLudA/GSDq/ef1ga68HwKlcLw5hdDmtehQcqZHUqshAFUeCE+EGC81QcVk9Wd4WZBss79U33mleFvrIBUah2fjIhmwrBdLIf8UmMA==

On Tue, 03 Nov 2026 01:05:27 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] tracing: successful marker write overwritten by tail error in marker_copies
> --
> 
> commit 2345280f3b3625fa6e36116fc50947e792b25719
> Author: Jaewon Jung <jaewon8868@gmail.com>
> 
> tracing: Keep copying markers when one instance is stopped
> 
> This commit removes the early break on write errors in tracing_mark_write()
> and tracing_mark_raw_write() when iterating over marker_copies so that
> stopped instances do not prevent remaining instances from receiving markers.
> 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 08614af8fad1c..0b66c55d378b1 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6330,8 +6330,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
> >  		guard(rcu)();
> >  		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
> >  			written = write_marker_to_buffer(tr, buf, cnt, ip);
> > -			if (written < 0)
> > -				break;
> >  		}
> >  	} else {
> >  		written = write_marker_to_buffer(tr, buf, cnt, ip);
> > @@ -6409,8 +6407,6 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
> >  		guard(rcu)();
> >  		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
> >  			written = write_raw_marker_to_buffer(tr, buf, cnt);
> > -			if (written < 0)
> > -				break;  
> 
> [Severity: Medium]
> As reported by Steven Rostedt on v1 [1], should errors from stopped
> instances in marker_copies be prevented from overwriting a successful write
> return value?
> 
> When instances enable copy_trace_marker, update_marker_trace() adds each
> instance to the head of marker_copies:
> 
> kernel/trace/trace.c:update_marker_trace() {
> 	if (enabled) {
> 		if (tr->trace_flags & TRACE_ITER(COPY_MARKER))
> 			return false;
> 
> 		list_add_rcu(&tr->marker_list, &marker_copies);
> 		tr->trace_flags |= TRACE_ITER(COPY_MARKER);
> 		return true;
> 	}
> 
> This leaves earlier-enabled instances and global_trace at the tail of
> marker_copies.
> 
> Because tracing_mark_write() and tracing_mark_raw_write() unconditionally
> assign written on every iteration of marker_copies, if an earlier instance
> in the list is active and receives the marker (setting written = cnt), but
> the last instance in marker_copies has tracing disabled,
> write_marker_to_buffer() or write_raw_marker_to_buffer() will return -EBADF
> on that tail instance. Won't that overwrite written and cause the syscall
> to return -EBADF to userspace even though the marker was successfully
> written to the active instance(s)?
> 

We only want to record the the output of the global array, so we should have it be:

	if (tr == &global_trace) {
		guard(rcu)();
		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
			ssize_t w = write_marker_to_buffer(tr, buf, cnt, ip);
			if (tr == @global_trace)
				written = w;
		}

-- Steve
