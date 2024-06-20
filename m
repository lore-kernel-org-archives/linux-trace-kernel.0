Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FE1BA06A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912435; cv=none; b=Ek++A1ITQg0fr3vr73IArwPke1meVyS6QX94ez5NsBRrzbYv0/+XR6XzjzqBadQ5oCJYPsuwN2vT7Hc8D/GVAY1drWlXSTwELZ/a/0FN5+hKlJZYv3ZPQFyfr6kp0TVW7TQQOE5bVv32OVkqOeKA3jzel40m7aeNi5GWbW5vWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912435; c=relaxed/simple;
	bh=u5zNNqjXlyw110nBNYIGAGabZlG/rsTKJ2r1fT5/TIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNPjpGQZoHe425TE9D7Zz9QJFk4FlcIV8TOK9jSzqnupWr1t811cm0yKeBrwXL7xJ/p+bGziMUIVwlmCT9fwQ8Ml9yp/J7ju1UoVy4Ej98vTs64i3RnQ+7f8+ynkCcEuw5tHOiIJCHwB3NqMLwk/JCSq0sow9+uGNvaFUvtMesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=buVkjwuS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buVkjwuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718912433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u5zNNqjXlyw110nBNYIGAGabZlG/rsTKJ2r1fT5/TIk=;
	b=buVkjwuSeVu1N43GtRC4/BmI5DtXMMKIGNWmXKLGY1/tkxoJcckapPrViIBdKwX24QKu4V
	Zu5gg6SdRlUPOHWY7UX6nQeZqEDCWjUyRuViYA+TS3xA8HJzBnuT49NwCT+hgXVEA0sW7f
	m/Ac9k8RMNuZ2q28ExhfI87aeB13Kn4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-ZXWX-ZlGPveGNUBTWihMRg-1; Thu,
 20 Jun 2024 15:40:25 -0400
X-MC-Unique: ZXWX-ZlGPveGNUBTWihMRg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5384F19560AB;
	Thu, 20 Jun 2024 19:40:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 84A941955E74;
	Thu, 20 Jun 2024 19:40:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Jun 2024 21:38:51 +0200 (CEST)
Date: Thu, 20 Jun 2024 21:38:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] uprobe: Do not use UPROBE_SWBP_INSN as static initializer
Message-ID: <20240620193846.GA7165@redhat.com>
References: <20240618194306.1577022-1-jolsa@kernel.org>
 <CAEf4BzbN4Li2iesQm28ZYEV2nXsLre8_qknmvkSy510EV7h=SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbN4Li2iesQm28ZYEV2nXsLre8_qknmvkSy510EV7h=SA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/20, Andrii Nakryiko wrote:
>
> Can we instead ask loongarch folks to rewrite it to be a constant?
> Having this as a function call is both an inconvenience and potential
> performance problem (a minor one, but still). I would imagine it's not
> hard to hard-code an instruction as a constant here.

I was going to ask the same question when I saw the bug report ;)
The same for other users of larch_insn_gen_break().

But I can't understand what does it do, it calls emit_break() and
git grep -w emit_break finds nothing.

Oleg.

