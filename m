Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D17224D5
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801435; cv=none; b=FboSPriECmQUKzfucsdPvQ2jvroBzIZs8LV242YgfRHzVz0HsCmN0BOQKTxcb9fABfBtD33ZRtxssGm8etaTEUpP0DfbBsnVh8K6pdDegEzZLuD05UA2IVTj+bWDVkPBefw8hg1zjkl6WT6xdJVKvuhUEFhGOkEzFaSETeATH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801435; c=relaxed/simple;
	bh=vOTtrQjeC7XaM50trnCEYdVH4ZodHQJt5bpJ/0mXWe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVGfj+5ZtSwelJt+IFf4i3ARD6NcfLaaTnOgMy3eeSMPovTRq0OfyOQfSslsaUh3Ls+3rqEtathG/GL5rjSfF3lrD63fFRY1oNckqLy25mreQyeLj8zJSn1swSiGGiaib4yNkCb9XwvrbivAxX4GHxMtzPXVJNKKX2uiTRLFVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWzqoWyi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWzqoWyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713801433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Re0lafXu7wQslD0LP+mb5k+NPK2CcD7U/L0lGd24osU=;
	b=QWzqoWyiQmF7oyoAHt2LdOiGNquPncApwK0JK2TFhF3LZI7O1KeobiztUNMHJf+5tOCDWS
	KezRHztIyRiv7Fin1C7aHgdK6W5zT5PdaBe6ZdCkSGJnbz0C5Q8KlHiP/wbXKb5MeFaLeN
	iH8OYn7gq3Z3olp93rljWF1I/5pLGk4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-oFXsibcKO8e3VSnl-i3laA-1; Mon, 22 Apr 2024 11:57:11 -0400
X-MC-Unique: oFXsibcKO8e3VSnl-i3laA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05B1E104B502;
	Mon, 22 Apr 2024 15:57:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.205])
	by smtp.corp.redhat.com (Postfix) with SMTP id 954FD200E290;
	Mon, 22 Apr 2024 15:57:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 22 Apr 2024 17:55:45 +0200 (CEST)
Date: Mon, 22 Apr 2024 17:55:40 +0200
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
Subject: Re: [PATCHv3 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <20240422155540.GA32422@redhat.com>
References: <20240421194206.1010934-1-jolsa@kernel.org>
 <20240421194206.1010934-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421194206.1010934-3-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 04/21, Jiri Olsa wrote:
>
>  arch/x86/kernel/uprobes.c | 115 ++++++++++++++++++++++++++++++++++++++
>  include/linux/uprobes.h   |   3 +
>  kernel/events/uprobes.c   |  24 +++++---
>  3 files changed, 135 insertions(+), 7 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

