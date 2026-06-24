Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5B175A67
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315429; cv=none; b=nLnekSmVC9s21fbhdK4u/wDWc3fuEQpXe2pF56oPziaQwPjGs+9u5RpnSFEJ9qYX3Vu+8a8fx4WKRPd6ENW7uxpe26zs+gZ4Qi9eBKXxLR7Z9vEYOGqiBFKpwZrTkiXj7svPQr3uYzNoqoBiSbVZ+MEA5w+nlDWNDLAtxgNHKXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315429; c=relaxed/simple;
	bh=3Te0Yr/FkWBIIu4mYKVif++lEW0UJpTf+gv92hcjtM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gluAwRX9ARHFwC7k07uXIgKvIBxMAKXaqf5d1m8mFwwIOUC30xpcs+V8pfw/jEkA74+iqTj9Ix8G3tqsw/lwBWL7XKiRnKHEjgnVjqml+Cz2Lq1Qr8Q4UptniQppdSmcqsEcrOLWGdfklK7CwP1KnBFifkqYPYrbt2JRRmYPjno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZfoniQF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZfoniQF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782315427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Te0Yr/FkWBIIu4mYKVif++lEW0UJpTf+gv92hcjtM8=;
	b=JZfoniQFn1ShXeTN2xdBi+CwX1XNLVgTU3sAZ08KPr7yCeYlWl8HTLCK9/98pI06Fert0Y
	MPwWG/aFWXoDM48DnGV1RRZpCQsMMO/aA7Uw3TkOgZDNdS6AmF/3nnfKQKF08b6xu2xKcu
	1ExUDB3bnDIrc850hca/JQhwtx4qDzw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-gRKtLGZ3OLSjk886F7Naug-1; Wed,
 24 Jun 2026 11:37:02 -0400
X-MC-Unique: gRKtLGZ3OLSjk886F7Naug-1
X-Mimecast-MFC-AGG-ID: gRKtLGZ3OLSjk886F7Naug_1782315421
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 248E21805A16;
	Wed, 24 Jun 2026 15:37:01 +0000 (UTC)
Received: from fedora (unknown [10.44.33.191])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 20ECC3000B76;
	Wed, 24 Jun 2026 15:36:56 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 24 Jun 2026 17:37:00 +0200 (CEST)
Date: Wed, 24 Jun 2026 17:36:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 04/13] uprobes/x86: Unmap trampoline vma object in case
 it's unused
Message-ID: <ajv5lxWjNHBAUa9r@redhat.com>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-5-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260526205840.173790-5-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: l7B17cRxJwnZy87K_2PGjXDH1fe1TIAdvsOi-6ANXQU_1782315421
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 05/26, Jiri Olsa wrote:
>
> In case the optimization fails, we leak new-ly created trampoline
> vma mapping (in case we just created it), let's unmap it.
>
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


but I am a bit confused... It seems that this change doesn't depend on
the previous 03/13 which removed VM_DONTCOPY ? So I think this patch
could come as 3/13 after "Remove struct uprobe_trampoline object".

And the subject looks misleading to me. A tramp vma may become "unused"
if (say) we remove some optimized breakpoint, afaics it will be never
unmapped. Perhaps it should say something like "don't leak on failure".

But this all is really minor, please ignore.

Oleg.

