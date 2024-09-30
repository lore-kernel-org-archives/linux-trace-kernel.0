Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A33E18A6B9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688912; cv=none; b=VgY1zzXSHyGvjrehI/jqSCES0oL+AwRdPnhPdPt4WGE+gVObIGDXrePXWHcZF4l4qCdrzIH3bqDD8znTKYfCKmy2GMTGrHOH2s2f/rw1q2f30VUyVxrdtrX7A96XSMCmYlSpgFJzDx6RIFQKbryzstq/2jvUWbG+Qrt1OU9v9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688912; c=relaxed/simple;
	bh=yscA1gaN/DnJapmSgPfK3se0S5RkDHatRVMuYJgu550=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0oyDEejpgCtkT2EwAAq65rgk3aypVYw1sqpYHVC7GFrnJqh2SPTgAjwXGJrNbhKQ4yW8U1a45ki+ms/7vnj6c/NgigpBARiTjS5n1S/wSfNoe36sfGfNFjRknUYYdDiZje7ym+Sy40lDmUV7UOnHYyj8Fcj1cUbVugfLAW+tH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJIHpHYq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJIHpHYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727688909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yscA1gaN/DnJapmSgPfK3se0S5RkDHatRVMuYJgu550=;
	b=WJIHpHYq7MQKrCPQT9085ClWnESCRlmhZ8AYBzyeTjhT2Cot5UqL/F5IuEVpWYqmSExZwA
	J8v9pS2EFEBFZNZdmGSZf/vG1Ul025VRK1h3cWh8JHGmYIZ+6VZS8kt6bF4kewxbmnZNq/
	7SYtR9I+eTb0fqJwcAbg3Dcq+OsUmcw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-D2pozy5EOAazDhbGIcsn_g-1; Mon,
 30 Sep 2024 05:35:03 -0400
X-MC-Unique: D2pozy5EOAazDhbGIcsn_g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F5318E68CC;
	Mon, 30 Sep 2024 09:35:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C827A3003E4D;
	Mon, 30 Sep 2024 09:34:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 30 Sep 2024 11:34:47 +0200 (CEST)
Date: Mon, 30 Sep 2024 11:34:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 01/13] uprobe: Add data pointer to consumer
 handlers
Message-ID: <20240930093440.GA18499@redhat.com>
References: <20240929205717.3813648-1-jolsa@kernel.org>
 <20240929205717.3813648-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929205717.3813648-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/29, Jiri Olsa wrote:
>
> Adding data pointer to both entry and exit consumer handlers and all
> its users. The functionality itself is coming in following change.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Oleg Nesterov <oleg@redhat.com>

