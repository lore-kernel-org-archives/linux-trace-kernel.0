Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B16026AF5
	for <linux-trace-kernel@vger.kernel.org>; Sun, 27 Apr 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745763270; cv=none; b=afoOOXvCdfN6w+rGw0ir/FgM34M5LjpSAq3XUJc+cGeLVZVjAY4dw21vEZStaGkjcunKFIH3RaX7qN+ZePykQAThzV2NPlF4dbHvS/SQ2iz0oIi4fc1iUzcwLjJidI+8XTgll7gS1bVemEkUbFvSfTb4/Up52D0TUWK3qScMSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745763270; c=relaxed/simple;
	bh=49DuRZhOVTYQFxHgGdK6okYEXh4PRTvvhmby35xZFuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT5cffYCaMk5QcKXHTMNgk54jzvMmFny4f61A1UQVIhRzq+ZRQgNREeVgeoblQ+VM3ULezwGq7mW27qqLEssfDMCnBGO8Wam4n4ITDU5PlpVRJ4JQi4znEBJpnPo0/mMZzAXZfINJoqkhgd/+vIdTg9PM8zk7PaCr3i5Qka4P+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXcPI9+9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXcPI9+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745763267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BNjVVte3p3EsUaESR/jga3ypvTF1DEPySfxUJUdW+ts=;
	b=bXcPI9+9lonLqs5R/8OBokOBXDQVc34+voE2UVdaU9Jk8T/KJGTAOYclSd4YYkhElnLkP6
	u/YZ+wOKss/1QEpAr2IvNow1zwkTwCnNjv0AXrmdEdY5OQQMgOTX9kemii4PcOqbjxLFdt
	aVaOlB3ezvNXjhxoOYTPjB+3rEMFVCg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-NkxcXgFHPNizLPHKlO-eyQ-1; Sun,
 27 Apr 2025 10:14:25 -0400
X-MC-Unique: NkxcXgFHPNizLPHKlO-eyQ-1
X-Mimecast-MFC-AGG-ID: NkxcXgFHPNizLPHKlO-eyQ_1745763263
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A589C19560AA;
	Sun, 27 Apr 2025 14:14:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 645D1180045C;
	Sun, 27 Apr 2025 14:14:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 27 Apr 2025 16:13:43 +0200 (CEST)
Date: Sun, 27 Apr 2025 16:13:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 03/22] uprobes: Move ref_ctr_offset update out
 of uprobe_write_opcode
Message-ID: <20250427141335.GA9350@redhat.com>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-4-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421214423.393661-4-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/21, Jiri Olsa wrote:
>
> +static int set_swbp_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, unsigned long vaddr)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	int err;
> +
> +	/* We are going to replace instruction, update ref_ctr. */
> +	if (uprobe->ref_ctr_offset) {
> +		err = update_ref_ctr(uprobe, mm, 1);
> +		if (err)
> +			return err;
> +	}
> +
> +	err = set_swbp(&uprobe->arch, vma, vaddr);
> +
> +	/* Revert back reference counter if instruction update failed. */
> +	if (err && uprobe->ref_ctr_offset)
> +		update_ref_ctr(uprobe, mm, -1);
> +	return err;
>  }
...
> +static int set_orig_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, unsigned long vaddr)
> +{
> +	int err = set_orig_insn(&uprobe->arch, vma, vaddr);
> +
> +	/* Revert back reference counter even if instruction update failed. */
> +	if (uprobe->ref_ctr_offset)
> +		update_ref_ctr(uprobe, vma->vm_mm, -1);
> +	return err;
>  }

This doesn't look right even in the simplest case...

To simplify, suppose that uprobe_register() needs to change a single mm/vma
and set_swbp() fails. In this case uprobe_register() calls uprobe_unregister()
which will find the same vma and call set_orig_refctr(). set_orig_insn() will
do nothing. But update_ref_ctr(uprobe, vma->vm_mm, -1) is wrong/unbalanced.

The current code updates ref_ctr after the verify_opcode() check, so it doesn't
have this problem.

-------------------------------------------------------------------------------
OTOH, I think that the current logic is not really correct too,

	/* Revert back reference counter if instruction update failed. */
	if (ret < 0 && is_register && ref_ctr_updated)
		update_ref_ctr(uprobe, mm, -1);

I think that "Revert back reference counter" logic should not depend on
is_register. Otherwise we can have the unbalanced update_ref_ctr(-1) if
uprobe_unregister() fails, then another uprobe_register() comes at the
same address, and after that uprobe_unregister() succeeds.

Oleg.

