Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F82BE7AE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 May 2025 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747151223; cv=none; b=m1yMsFW1h/G6LJJWBLjxbix39d7FJgSzyBkOj9HFKjD4YdBjN2xnAZWrdKIx4CLJMcgvl/GBeV/ds/fbHQvtRdygf8hqN1AcFrT31foA9dM/tvwqbRdCEH7j4IEfxFClaAI4hiomDQm/+lpmT0Nj5vxcMkRWGy085xazJOFVg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747151223; c=relaxed/simple;
	bh=aKfYPwMjbQ2ut0CHCdSZS9rO32RR/ysjSXNgz6gdx7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzOaaGeOLZUJ1/Wzgnzr2H08oiKeiYJbWLvRvNJLbelNGUwzvQY/uhVHFubUU6iaPfUvPq6XfdFyHoY33VMD4c4i06taQ+a7CnhGFrVSd+/PGTEM+g++Cull5m9liKXp5H6J8IouiJwp6BXlty73X+PGMoB9T3oF21D3xUkYAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEfLnzsM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEfLnzsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747151219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1EoFODGgtQlH8iAxw0nt4puzOn0SEDaT4eXMVX63NuE=;
	b=HEfLnzsMuJl+MCSVVZJlx7OCowIz/dbTu3GbQ3cL07WH4Lohd2/RVGxZNlOhdMXEDMl3x2
	UqAfuRGz6SkEJHgqyVWbAIUEG3+2ncLLjrIllM/blS8GYsWQyrqtCDSSk9yVoPizhOADyA
	ucePV4EKQuy5dEAQ2pS/rpE6bc/jURA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-VmiCkp95Ph2-AEtOA9W4dg-1; Tue,
 13 May 2025 11:46:58 -0400
X-MC-Unique: VmiCkp95Ph2-AEtOA9W4dg-1
X-Mimecast-MFC-AGG-ID: VmiCkp95Ph2-AEtOA9W4dg_1747151217
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3E771800360;
	Tue, 13 May 2025 15:46:56 +0000 (UTC)
Received: from fedora (unknown [10.45.224.118])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CF0411944A82;
	Tue, 13 May 2025 15:46:53 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 13 May 2025 17:46:56 +0200 (CEST)
Date: Tue, 13 May 2025 17:46:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH mm-stable] uprobes: Revert ref_ctr_offset in
 uprobe_unregister error path
Message-ID: <aCNpbPuY6FI1Aiyx@redhat.com>
References: <20250513122125.1617722-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513122125.1617722-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 05/13, Jiri Olsa wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -581,8 +581,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  
>  out:
>  	/* Revert back reference counter if instruction update failed. */
> -	if (ret < 0 && is_register && ref_ctr_updated)
> -		update_ref_ctr(uprobe, mm, -1);
> +	if (ret < 0 && ref_ctr_updated)
> +		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);

Acked-by: Oleg Nesterov <oleg@redhat.com>

And just in case, I agree this has nothing to do with the recent changes from David.

Oleg.

