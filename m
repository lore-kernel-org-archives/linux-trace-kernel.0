Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B2190077
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 Jan 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735989037; cv=none; b=LhNHsQIlYwfm9cnAh90fP78JdjWBrHkUFYmy8LXlGywkl+nLXFV0xF3QsLZFICRKhIjpGT0JZKzXx+L1REX5IIxC55disQXXDkwHYtWzLNEuCYgWoeemF1k1Rht987CoOg8iafU3CaCgUCcOQN/A+oizvT3NIKV2UZeN7Vj6rCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735989037; c=relaxed/simple;
	bh=TnASljll21o6F8Y+dpLF5AnIq0TGRGiEEytIeCD/eQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxtew7K0ckd84LamDqjmQ07qFPIB0G8NiHVoLl7laAMqJrxPApJgkGBFNf36cASfTKLM9a2/L/CLglyc9wQIpmGl4kNRFfcvx9TXSR5QuRUiGby0G+XrZd8DwMZY+BwkSssz29HkmYQFI5k0XUivHiMBpmugWI8+hGHlyLjpNhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/ckOp8a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/ckOp8a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735989035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06Obat5T6WtwcmaJYmEzJ4dbTUQy+ZiF6aQhlBAZ87g=;
	b=V/ckOp8aygK4Zmf8n/M9ShUos4SOzcZR6wgDxMcMyShXS4RNg2zhF1tgV2om7FQFvbyxtp
	Lgnu5eHQ7UMGwDEJFmnw9Wdx9QOABFC63fKgbYAyDVdoba6TJx6FWgiTpA/kNktxBgXUCJ
	9m8HynB+WExRcGqDBIVtlkQIh+oeAgY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-sElH8cAXPlOciTIJ5E174Q-1; Sat,
 04 Jan 2025 06:10:29 -0500
X-MC-Unique: sElH8cAXPlOciTIJ5E174Q-1
X-Mimecast-MFC-AGG-ID: sElH8cAXPlOciTIJ5E174Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B1CA19560AB;
	Sat,  4 Jan 2025 11:10:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 31E1D195605F;
	Sat,  4 Jan 2025 11:10:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  4 Jan 2025 12:10:02 +0100 (CET)
Date: Sat, 4 Jan 2025 12:09:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] Provide __free(argv) for argv_split() users
Message-ID: <20250104110955.GA2394@redhat.com>
References: <173594528527.1055889.2175884987203674189.stgit@devnote2>
 <173594530753.1055889.17844868397124331132.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173594530753.1055889.17844868397124331132.stgit@devnote2>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/04, Masami Hiramatsu (Google) wrote:
>
> +DEFINE_FREE(argv, char **, argv_free(_T))

This doesn't look right, I think we need

	DEFINE_FREE(argv, char **, if (_T) argv_free(_T))

?

From the next patch

	@@ -73,24 +73,20 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
		struct dyn_event *pos, *n;
		char *system = NULL, *event, *p;
		int argc, ret = -ENOENT;
	-	char **argv;
	+	char **argv __free(argv) = NULL;
	 
		argv = argv_split(GFP_KERNEL, raw_command, &argc);
		if (!argv)
			return -ENOMEM;

if argv_split() returns NULL, then __free_argv() will call argv_free(NULL) ?

Oleg.

