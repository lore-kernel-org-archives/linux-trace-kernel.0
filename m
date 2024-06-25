Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D614F16D4C4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326756; cv=none; b=WM5Jg/KWllGb8+cFlE4RRjWQSp+G3aGv1Rhe+F5hS1IdhMV0ztrLDik0K0IZbyP5/e2MMEYwKHjroJLTE6hN45y5sMFL3a/dlYs1Vua7W0jDL40Sh7c9/F5ZLTqPKfK2Uly/noXCBLDjLMmnsIpORUc4mjvw35kdJgzte31sn8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326756; c=relaxed/simple;
	bh=fcUK0z11x4X/G/JqYJIrF976nUZSEtPwTuCSXYlRn4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb2b7YqX7JNLGLi/txfEgV7YfVOO8L03cd0Blpg5yZmbXH+vB9ogrv6XH7BbylCi8TWcLnOLHb3DWOKApVuBY5Zc3nxvI+0Lf1e9l698eS7KadnUomfgYbPqpxcYulwVHdbC63I4wsVjhIP2A4hCgX56KjmrAkRZRhez9kmLLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/Cl7D49; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/Cl7D49"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719326753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LdWdE9aRa9ajaGrxs2vQdnhx3Rv5rWQKcF4xVyz2uo=;
	b=e/Cl7D49K6E0ga+pzPoui/dMWhG7h2T9axFDkOEBUTGAjF4pFVP+6IqCv9C0dNoFCtO3IR
	v1YsV2H4zGtIYAyDMIQ6ToDiFn5t5rEjoWvt3eNddFTCPCm9RLd7lWcCLSl//mlKo6N1P0
	VzpAmxoLd/uvcTD+lrwPHc/4YHoLm2A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-Soxs7XA_OfK6uYm0puIiJQ-1; Tue,
 25 Jun 2024 10:45:49 -0400
X-MC-Unique: Soxs7XA_OfK6uYm0puIiJQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D735519560B8;
	Tue, 25 Jun 2024 14:45:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3B82E1956087;
	Tue, 25 Jun 2024 14:45:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Jun 2024 16:44:14 +0200 (CEST)
Date: Tue, 25 Jun 2024 16:44:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240625144409.GA21366@redhat.com>
References: <20240625002144.3485799-1-andrii@kernel.org>
 <20240625002144.3485799-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625002144.3485799-5-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Again, I'll try to read (at least this) patch later this week,
just one cosmetic nit for now...

On 06/24, Andrii Nakryiko wrote:
>
> + * UPROBE_REFCNT_GET constant is chosen such that it will *increment both*
> + * epoch and refcnt parts atomically with one atomic_add().
> + * UPROBE_REFCNT_PUT is chosen such that it will *decrement* refcnt part and
> + * *increment* epoch part.
> + */
> +#define UPROBE_REFCNT_GET ((1LL << 32) | 1LL)
> +#define UPROBE_REFCNT_PUT (0xffffffffLL)

How about

	#define UPROBE_REFCNT_GET ((1ULL << 32) + 1ULL)
	#define UPROBE_REFCNT_PUT ((1ULL << 32) - 1ULL)

? this makes them symmetrical and makes it clear why
atomic64_add(UPROBE_REFCNT_PUT) works as described in the comment.

Feel free to ignore if you don't like it.

Oleg.

