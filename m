Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0250276
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510731; cv=none; b=kI00eThg+0Y3cKpLT3ZlPJtOrV5yDPq3OpgY8lfx+Lo7mpjpnVbdgTW0NPhFRYuDgqfwFClnCZ5Lzf5crPj0X2lrt64pXE5gPPSuqiekvwIwh9bFWXrWoOoq69ZtEAQxUNbL67DzR1hIKRUIlMNr+xwW/00hY65ZJWeoMYJxUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510731; c=relaxed/simple;
	bh=3SphJHg4v3KMVtyDixLd6nOd6cU9IqiHwTCFp8m9250=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ftUCJLKt+sIBsZP2WXiouSyWakTcr0/D/qyscICbEc6q/9IBqupiFl3z+Zs7It8ZHoJOF2/fqfkezPaJN1ulW5jxCbNL1WHV+AGwAHRuLOGtoxQ/Z9coIhsnfAaF6Uz8IKgmobUNGM6AAR8T8tAtaszNQL6yAxhSAgFQnL3NFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FXqqHcmF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXqqHcmF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778510729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YVZpWY4BuSkSaiEWOd+1uYFRTLMnLND0svp2dx2nzQ=;
	b=FXqqHcmFoc52FrzmrHgfkqqwrrM9rYPx4SWaSfhXsjPO8FBOT2VnxtmOA76SnNa/NFjQqa
	5/W/UjRCrDwWdqJc93yaV3SnE8/JL2yhW19mvNWN+ZlmgXIwZ2KiifG+hM5IGNT6v31XdA
	PrrAdOE0BIAxSpex24d4PaeHRimgZOA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-QObgPfkqOcKXnCMIppwLcg-1; Mon,
 11 May 2026 10:45:23 -0400
X-MC-Unique: QObgPfkqOcKXnCMIppwLcg-1
X-Mimecast-MFC-AGG-ID: QObgPfkqOcKXnCMIppwLcg_1778510719
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7351118002F4;
	Mon, 11 May 2026 14:45:18 +0000 (UTC)
Received: from fedora (unknown [10.44.48.223])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A81873002D31;
	Mon, 11 May 2026 14:45:15 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 11 May 2026 16:45:18 +0200 (CEST)
Date: Mon, 11 May 2026 16:45:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	jolsa@kernel.org, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5
 optimization
Message-ID: <agHreV1m7MRKUtbh@redhat.com>
References: <20260509003146.976844-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260509003146.976844-1-andrii@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: LGqFz4-1OsNVv0uWXR_YkBlzrVR-wYhnlAOVlhiXub4_1778510719
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 05/08, Andrii Nakryiko wrote:
>
> +static bool resolve_uprobe_addr(unsigned long ip, unsigned long *probe_addr)
>  {
> -	struct vm_area_struct *vma = vma_lookup(current->mm, ip);
> +	struct uprobes_state *state = &current->mm->uprobes_state;

it seems that there is a problem, with or without this change...

Lets forget about this patch for the moment, I am still trying to understand it.

What if register_for_each_vma() calls install_breakpoint(vma) and
vma->mm != current->mm ?

In this case install_breakpoint() path will call __is_optimized() and then
__in_uprobe_trampoline() which does vma_lookup(current->mm). This looks
obviously wrong ?

And unless I am totally confused, this patch "inherits" the problem...

No?

Oleg.

