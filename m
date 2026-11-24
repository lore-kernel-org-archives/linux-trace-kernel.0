Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795487282;
	b=BXYbsKEWv0h6aPW1MMPC0xXi8ZaS8WPQh+o1bRXRFx6GzJ197eqeOLVCoYth79mYlxAD
	 t6HCcWn+GDUZz46WMDs09MwT0kyqx4+UoyaJgBzB9BKeOQcsCqNTZmiUcyAHzFiXcVGUy
	 MrP2vEtE6QFQSn0Z0z4+RYA0ApUvY9zOEEq7Wi1/lg6zE9dUJMaxi46NQhh7hJd/nDHrl
	 rRoaKkXpB8WH8rzvp880kHES/Iyx8vu8lIhpANwrZi7GhIxRbrbmzd4Q1W2Dt+h9tSUdm
	 FaSQYg2v11tT/oX1V5EFCJe+tBvQrHwPY9BECfGzmZfpYFtd878aDjP8I/HPUDyM6WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487282;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=JppmzHS+tYT5us6OVA3E5d8UWpwSgTytZW8qCLT12xs=;
	b=g+vxX/gKa0V/FF6ib2TxViM65Dx4j9ruVQH4vrG2iZUzs1g6xAr0kBGQfUtxabvoqhsl
	 +/MvpYJc2XFW79NULlIoHOLwEJIuZ3wJSjaH5j0+2n7+PGGJnHmO8fOryW3Vfm9Nq7R/y
	 NDE5zLRaYr8ztepr871H8q+3ZD1+kFT0LR9+oGRdec12jGIs6qpSEAlJt6kJ89R3ZEHFn
	 6g3bAq5w7mU3DAvCCWncLmfW6RJR/voSe9pHphL0ELniDcv2w4AyflHm3jRLdjfFr/aeV
	 DB+LbqxX0DB/dO9UpLiHHKd9axewGdVGXqQMhk6xNR5u4AU9Yf0fs1VMcBXDR5z9AEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=cQUrAjbm;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE95606A31E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 02:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFE95606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=cQUrAjbm
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id AFE2F16096C;
	Tue, 24 Nov 2026 02:27:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 0D2E86000C;
	Tue, 24 Nov 2026 02:27:57 +0000 (UTC)
Date: Mon, 23 Nov 2026 21:27:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Linux Trace Kernel"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261123212756.46f6708d@robin>
In-Reply-To: <sashiko-outbox-230090@kernel.org>
References: <20261123163027.4d101385@gandalf.local.home>
	<sashiko-outbox-230090@kernel.org>
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
X-Rspamd-Queue-Id: 0D2E86000C
X-Stat-Signature: jxojqnj6dttmm5zxjcdiuygdx4rpdcgy
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+NaYGPs1MSPHHh0dDB/GqjNr84XJtY7dk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=JppmzHS+tYT5us6OVA3E5d8UWpwSgTytZW8qCLT12xs=; b=cQUrAjbmP/bwpE7QMk9hAwwoTbAuaPdRsUpFC48TLqr/gj+icpl52U4JiYAykikGRGMRgofLLoCJ2/bWPD5SIaBFf2su5DGea4xHaSs7SCig9BgFt6HT7jY4Yi91gv1sn1O4I6AIEBvdHI6lwEDvJrWsh7tesPFZ9ShybVB4xAQ=
X-HE-Tag: 1795487277-974071
X-HE-Meta: U2FsdGVkX1+nl5ffqe52ibgc2LKbWsV6ABiLvhY9ZB4KTHTD5LtYej77hWoAwP2q9xLDVnAugG986nnRzpjLjcpgZTEGbimBVwB9Q5sLhdCNrmR/fATOosnr/84hDCQ844DaSGNLMjacqjwD5HlXXKXSo3z4X+WiiuygtDJMgLq8CG/3IxGE8SuEIoWJ656ceGBu7xYKJnFvalu6dY0fcorAEXVzl/LD32aMBgTZIq+qj+P6WUl3CXUMUdsR5mZEBIydiHe6DGnN6UT986DC/7zwaoYbC0dahu3mI6XGd/9wTUj5mSPwdPZJV+FWuWVaasCX5GhJNM9GrHHWmLOZP6h5SvSTGBOR

On Mon, 23 Nov 2026 21:48:08 +0000
sashiko-bot@kernel.org wrote:

> > +
> > +static nokprobe_inline int
> > +do_fetch_store_string_user(unsigned long addr, void *dest, void *base)
> > +{
> > +	/* NULL addr gets zero size string */
> > +	if (!addr) {
> > +		*(u32 *)dest = make_data_loc(0, __dest - base);
> > +		return 0;
> > +	}
> > +	return fetch_store_string_user(addr, dest, base);
> > +}  
> 
> [Severity: High]
> Does this fail to build because __dest is undeclared in both
> do_fetch_store_string() and do_fetch_store_string_user()?

Yes, because I forgot to commit the fix to this before sending the patch :-p

-- Steve
