Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D343D232450
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jan 2025 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875563; cv=none; b=WTL5njTeTCkqVpsz5vk1q/lYokYt6KDCGV/j+ianWa7e2f75enaBFzBFw37UEea0Tg9vKcoEZU8TkXgq5awWz0rzmeqq4xe/FViNc7F/kMBpYS5k7GZZvmLqqCQaroNxxpuXJeA3fZOlgpxFO7Kl4Hc4F4WjIBqV6mG+7QabU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875563; c=relaxed/simple;
	bh=SLnl86VoFy0CWx+1FAV3kgwVhMS3kbj5VROEq+77B8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDXuqMP8FVf0qaErXnMaW1YAaNqjg82z3JBR1JpYm1fF3dUjzT8uzNXJn+0oSMHN+oJqDC0QUYeTQ5AzIRBjCxLIP9zyS6gD36k2sTpBS/1ph1e7TL6pEm+cME6IOg1xT7WFWUoj3FhcYtG76sDsu2cYiUt+eg7SS/KWpcLmbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjLHJVLj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjLHJVLj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736875560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SLnl86VoFy0CWx+1FAV3kgwVhMS3kbj5VROEq+77B8M=;
	b=NjLHJVLjTXnu3xoIVeg+86KetFO1cCDWgMWhJ+AIMViMNV0kLwftgCUo5QZbBJJNfRTOVM
	gGT9JX9LjFfJdu6th6iWB+hBStCmK9vo8MOimNasTPLdkIeNEww8HWdR7gEbIIhzATqzk0
	6BohHVaI/egS+L0vRiSgG2pWXFb+LWU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-p1y7tBo5NA216Gitr3y_2A-1; Tue,
 14 Jan 2025 12:25:57 -0500
X-MC-Unique: p1y7tBo5NA216Gitr3y_2A-1
X-Mimecast-MFC-AGG-ID: p1y7tBo5NA216Gitr3y_2A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC96719560BA;
	Tue, 14 Jan 2025 17:25:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 571B7195608E;
	Tue, 14 Jan 2025 17:25:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Jan 2025 18:25:28 +0100 (CET)
Date: Tue, 14 Jan 2025 18:25:20 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
	mhiramat@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250114172519.GB29305@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com>
 <Z4Z7OkrtXBauaLcm@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Z7OkrtXBauaLcm@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 01/14, Jiri Olsa wrote:
>
> ugh.. could we just 'disable' uretprobe trampoline when seccomp gets enabled?
> overwrite first byte with int3.. and similarly check on seccomp when installing
> uretprobe and switch to int3

Sorry, I don't understand... What exactly we can do? Aside from checking
IS_ENABLED(CONFIG_SECCOMP) in arch_uprobe_trampoline() ?

Oleg.

