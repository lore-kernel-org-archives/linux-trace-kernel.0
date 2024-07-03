Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2EB1DFC7
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006973; cv=none; b=IiC/yHvUbDchsrus4Py1ANhwNcUZLnz8uEkyzAWQfUzYxCMLIFXH7qQOy6JDkgiIHmy0BU5kKyeIkBON3blnWkbrDiTYprnWqdaBAvqBsmuKPs/LsuLHkNcjsJh5keK2k9V+Ofm0vJ3g014SWc6kMcNBZ1hX0JEH8Dom1sO3h5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006973; c=relaxed/simple;
	bh=4sNK2ppBVN9/ZqYZi5JjZS4Zc7zCyu7uaoZJqNxVpwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8V052b9cMFg/Y8q+7/1uSqqFO1uVwr7Aqc0qmUuNaoGqp+o9Vcdn8+flXIcfDFM5edV1A0hcSkM1D1B4L7ySnyIrx7tz8JB2r6IE64OWkZLOm9JS3Dqspu4e8PMfIU+ZiZYbK4MqdWhEKy2XAhk+O/AC8ut15KcDJ4BZ9Tr6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBQ/Rckx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBQ/Rckx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720006971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/PZ6xrKTnI/WBJhbaJ3sWlKKb/IBmTt/4C2c0YjNIAs=;
	b=RBQ/Rckxp5VE/6ioAtNRFfBI6tu/83Lbsjv1EEar6MZ2SI0xGWB65bBkVaXwN+3HnNLTvq
	6lGuK+YPGW8dJmE9UuW231scN/Bse38HDHh5itj4zTAuDpDG0YHoSu7uDvnCYsAR3XDwHj
	Sglkfiv8GRtRQPgNtkVZ30/JVk81NSs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-yMnVDJd2OeOLH-_KWuHR9A-1; Wed,
 03 Jul 2024 07:42:46 -0400
X-MC-Unique: yMnVDJd2OeOLH-_KWuHR9A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 373EC1956095;
	Wed,  3 Jul 2024 11:42:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.202])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7117D1955F21;
	Wed,  3 Jul 2024 11:42:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Jul 2024 13:41:08 +0200 (CEST)
Date: Wed, 3 Jul 2024 13:41:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 02/12] uprobes: correct mmap_sem locking assumptions
 in uprobe_write_opcode()
Message-ID: <20240703114103.GB28444@redhat.com>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701223935.3783951-3-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/01, Andrii Nakryiko wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -453,7 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
>   * @vaddr: the virtual address to store the opcode.
>   * @opcode: opcode to be written at @vaddr.
>   *
> - * Called with mm->mmap_lock held for write.
> + * Called with mm->mmap_lock held for read or write.
>   * Return 0 (success) or a negative errno.

Thanks,

Acked-by: Oleg Nesterov <oleg@redhat.com>


I'll try to send the patch which explains the reasons for mmap_write_lock()
in register_for_each_vma() later.

Oleg.

