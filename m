Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B2C15350A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801568; cv=none; b=hTGZcnqUb7ZOxkQBMOGUcROxg81qAyOJ+I8ALmYGEol5dt5q4UkhuUvfYeb6OI9NaHB2prbNhH622kkMcMl7sX7qWINivuzsB6qhbg90lqOE9LwNSILOY9j69rHmmQQ1RkiuqV4KRKa2X0YCVen/lrfT++CNIfrueTTaNJ427Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801568; c=relaxed/simple;
	bh=9VMZddks3Ekgx883oDZjsDEI2XJ2LJ0ENmc3CoJLQx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqQdFBIk/WmzFjW94WS3UcgUFfPTz97iuZahKCP847tOPAO0xoLE55Ibo19TlT0YrburDbAki7d/dKNUAHhroAaBzfeY88BzwRs6OcPN8+3D/vP3b9w5GqaQ2VbAoFGu4RCAfMV9yBhleMcAfA1uSSOy7+6keW7ido9PGeXm8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYWcV1GO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYWcV1GO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713801566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZDVlmaFRH28jny24mSZR4RlhL/dQBLA0fwV8V32NgA=;
	b=bYWcV1GO3nZ7PqM4TTGUJfO4Gqh2p+bGiiIt0770xHbc4ppAC9/7WArEbcAvjgKWvSiCuU
	sTr99CLPmCcmVXGdBVeEYFZat6Qby2ErMn58DQF0YKCQriXdtnB5h/1tejjAYGU7sfUBp6
	gtSLS2nbaBBI/HCR9+RGX+kVQtf2lLw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-lelwKtoiNF2I2ygstDvVDA-1; Mon,
 22 Apr 2024 11:59:22 -0400
X-MC-Unique: lelwKtoiNF2I2ygstDvVDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 759A229ABA09;
	Mon, 22 Apr 2024 15:59:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.205])
	by smtp.corp.redhat.com (Postfix) with SMTP id 595AC1121312;
	Mon, 22 Apr 2024 15:59:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 22 Apr 2024 17:57:56 +0200 (CEST)
Date: Mon, 22 Apr 2024 17:57:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCHv3 bpf-next 1/7] uprobe: Wire up uretprobe system call
Message-ID: <20240422155751.GB32422@redhat.com>
References: <20240421194206.1010934-1-jolsa@kernel.org>
 <20240421194206.1010934-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421194206.1010934-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 04/21, Jiri Olsa wrote:
>
>  arch/x86/entry/syscalls/syscall_64.tbl | 1 +
>  include/linux/syscalls.h               | 2 ++
>  include/uapi/asm-generic/unistd.h      | 5 ++++-
>  kernel/sys_ni.c                        | 2 ++
>  4 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

