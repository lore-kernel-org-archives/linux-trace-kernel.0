Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD06319848
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Nov 2025 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007982; cv=none; b=RKcjqfktiBwQ7J1tA7L8ONXjnnAY0+R3Ae8fqqE2BvLz6ojnKDx/D5cF1whl+BqBEu4RDfxMhNLvwDY9rVUXVzmhUcDJwkkxBie422B8NOmm2TvDDnA2Kc9kpMTfIP73kRZJjllF45wfwfE347OYas3/+uK+c3UgXEGW2XbEFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007982; c=relaxed/simple;
	bh=5g5/iWn3yywlqRlYWAN4TF0WePP/0uXD2Y2Hmf4MdrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsBR7/vqqcwMizNvaoJqd82rnMrvFm9CUVqQ59d1hQMfZlGILUo1/RoMFCQLBOiv3eYkhwIkeuD2FGwuhbN/X6Xn753wC0Twg8cpvVMKKv6klTeJPWtedT8NOu1OVZUkXi/qLuaHtIrL9fLl+Xwv0jgqiXq3APgTLyy/o1J03oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgrZb8tZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgrZb8tZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764007978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5TjrlExZGDwZBDl59ofAP8W7CKBj8tBArhg9v+rJyqM=;
	b=XgrZb8tZU69qOdXSv4GOfp/lQf6YaA1JTZyQys3910vso8DNw3c7thX9bYT7i3lPpgzIbf
	6YTZVmd/+9YncIrojipXUBd3X2KB0IW3krXKmGuErHrCkWuGafyocuuhzWe5CreBrxo8pb
	fxLySU0n7h+ttNNNf140f45hSd8ea4s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-dCiO9QzWPpK2l0k8K9W3oA-1; Mon,
 24 Nov 2025 13:12:51 -0500
X-MC-Unique: dCiO9QzWPpK2l0k8K9W3oA-1
X-Mimecast-MFC-AGG-ID: dCiO9QzWPpK2l0k8K9W3oA_1764007969
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7927319560B0;
	Mon, 24 Nov 2025 18:12:49 +0000 (UTC)
Received: from fedora (unknown [10.45.224.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2416218004A3;
	Mon, 24 Nov 2025 18:12:43 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 24 Nov 2025 19:12:49 +0100 (CET)
Date: Mon, 24 Nov 2025 19:12:42 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [RFC PATCH 0/8] uprobe/x86: Add support to optimize prologue
Message-ID: <aSSgGu8X04XoYN8D@redhat.com>
References: <20251117124057.687384-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117124057.687384-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/17, Jiri Olsa wrote:
>
> This patchset adds support to optimize uprobe on top of instruction
> that could be emulated and also adds support to emulate particular
> versions of mov and sub instructions to cover some of the user space
> functions prologues, like:
>
>   pushq %rbp
>   movq  %rsp,%rbp
>   subq  $0xb0,%rsp

...

> There's an additional issue that single instruction replacement does
> not have and it's the possibility of the user space code to jump in the
> middle of those 5 bytes. I think it's unlikely to happen at the function
> prologue, but uprobe could be placed anywhere. I'm not sure how to
> mitigate this other than having some enable/disable switch or config
> option, which is unfortunate.

plus this breaks single-stepping... Although perhaps we don't really care.

Oleg.

