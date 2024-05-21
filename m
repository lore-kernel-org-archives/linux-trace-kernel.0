Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291C12FF95
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 May 2024 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301461; cv=none; b=fPwDBopfMyhNz5wtr4g8yNyz/cxaTP6g/Bg6h7iqVr+L8tNU8/B4Dzg/iGmW2v9A7RjTWa7Rr4NHSbyXGv7xjaMz9jyB5bqmEcoT6I7ATq8Dl5bDojmNmumi3TFdT4JTZu2Mh2W21/wGvsJNtfIqJgB93SVfs6gEXWN8W2u007I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301461; c=relaxed/simple;
	bh=tfhs4G1UxiGQsBmQ8SRV1xtzgUc9WBEgAUO1utJnNF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyZBSjnspRtkOEirPPTQM+02G2KGM2Z5QJ3V32e8JfJJkBeDE79DkqOmfBYszZ7IzscaiWlZjwak19CefhhI9drsjUr3VPyPA0n+RkL2aL16h4m5O20gujyldSAi6u4jG+0Sg2rnmR1biKJC2sJiEH0Dc1RVCnLUF06o+8sz7k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QG9WvKFD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QG9WvKFD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716301459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tfhs4G1UxiGQsBmQ8SRV1xtzgUc9WBEgAUO1utJnNF0=;
	b=QG9WvKFDOTtPcqi0zlOXyrMZuPpkyakmWalj+pNFPZnhnLszg4zj4dSVj5s8EQRQLSlZXB
	NOcgiDGg7EV54fByldzP5EptkVe1akwS526WpvlzJaZLLuCHGbe4FiW7ht1XqjI30WaiOC
	fIR8Ph64utj/fZ7BHf4uAeiEVEqHn4Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-nhnsxC0UO6SnsoRjeBDPPg-1; Tue,
 21 May 2024 10:24:12 -0400
X-MC-Unique: nhnsxC0UO6SnsoRjeBDPPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C79A11C03150;
	Tue, 21 May 2024 14:23:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.64])
	by smtp.corp.redhat.com (Postfix) with SMTP id CBF361C0948E;
	Tue, 21 May 2024 14:23:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 21 May 2024 16:22:27 +0200 (CEST)
Date: Tue, 21 May 2024 16:22:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv6 bpf-next 1/9] x86/shstk: Make return uprobe work with
 shadow stack
Message-ID: <20240521142221.GA19434@redhat.com>
References: <20240521104825.1060966-1-jolsa@kernel.org>
 <20240521104825.1060966-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521104825.1060966-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 05/21, Jiri Olsa wrote:
>
> Currently the application with enabled shadow stack will crash
> if it sets up return uprobe. The reason is the uretprobe kernel
> code changes the user space task's stack, but does not update
> shadow stack accordingly.
>
> Adding new functions to update values on shadow stack and using
> them in uprobe code to keep shadow stack in sync with uretprobe
> changes to user stack.

I don't think my ack has any value in this area but looks good to me.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


> Fixes: 8b1c23543436 ("x86/shstk: Add return uprobe support")

Hmm... Was this commit ever applied?

Oleg.

