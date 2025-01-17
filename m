Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F715228
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737074940; cv=none; b=mduMcjY2ZBeEryPGIQiEZeSzx2J2AXa79NzD4nYWbrdmub8/+JWfziNNFYSnNkpOYslII17BQcsW9JZV7S+o1HtqCeNyA+Wi4ks+0OFHQa0L/YXyQnVHLER4URsA43UI7TvwUzjGB2ldbNa5NvUpgv/RuZZxhwKZqxdda5lyH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737074940; c=relaxed/simple;
	bh=PF6tlMEavHU5JyIqtCZ3BQcgF+SKnhZPsWkxhlHwyOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djLOGyEEoKlErWji61Df8ysNeutHM1wnia9FPNC7Me+mlFoLU/huuUjrVPQj2fm/E3WFUwBOF/Kvk6Hhnv4tJHwzx78J8gUYO1eAzG3OqD6t6UnMjLEBGqvp5ujk2dhpjPFJw6Xy4m265eanBIrKvCfc++3Cf8cgzTeKO82Iy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBqM6n8E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBqM6n8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737074937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PF6tlMEavHU5JyIqtCZ3BQcgF+SKnhZPsWkxhlHwyOo=;
	b=UBqM6n8E7pHJZU+aiEIotsZ3npU8bDwxqI0ToCUP9XmLBHiTUE9of/44dZmUiZ5+jwagMY
	L/AeIvp0uPxSyecaCMqNztqB/e/q8hCgYwPwyY7vM+WiZgd1cs/NwsGpd485BU7dWb99PW
	Cyat729hx7EGdjcCMATuoiiqGpNkDRk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-hcMJTcvlPp2U_qsRdLVCyw-1; Thu,
 16 Jan 2025 19:48:52 -0500
X-MC-Unique: hcMJTcvlPp2U_qsRdLVCyw-1
X-Mimecast-MFC-AGG-ID: hcMJTcvlPp2U_qsRdLVCyw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6167919560A1;
	Fri, 17 Jan 2025 00:48:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.118])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2A7AB195608A;
	Fri, 17 Jan 2025 00:48:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 17 Jan 2025 01:48:24 +0100 (CET)
Date: Fri, 17 Jan 2025 01:48:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250117004814.GA2610@redhat.com>
References: <20250115150607.GA11980@redhat.com>
 <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
 <20250115184011.GA21801@redhat.com>
 <CAHsH6Gu1kXZ=m3eoTeZcZ9n=n2scxw7z074PnY5oTsXfTqZ=vQ@mail.gmail.com>
 <20250115190304.GB21801@redhat.com>
 <CAHsH6Gtd5kYPife3hK+uKafjBMx=-23UzvQgnOnqNDzSZgHyqw@mail.gmail.com>
 <20250116143956.GD21801@redhat.com>
 <CAHsH6GukV+ydR+hw_-RF=0=_x6aO7xZzkCmbc53=Pk0Kv=8hUQ@mail.gmail.com>
 <20250116153044.GF21801@redhat.com>
 <CAHsH6GshxQxw2euH_v+cvoCk=17GLQXgogUUWzLmo2P=gO9oLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHsH6GshxQxw2euH_v+cvoCk=17GLQXgogUUWzLmo2P=gO9oLg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 01/16, Eyal Birger wrote:
>
> Will do. If it's ok I'll put you in a "Suggested-by" tag (or
> co-developed - as you see fit).

Heh ;) thanks Eyal but I don't care at all. This doesn't matter.
What does matter is that you have found/investigated the problem.

So if you agree with this change, just send the patch and I'll
send my acked-by in reply.

Thanks ;)

Oleg.

