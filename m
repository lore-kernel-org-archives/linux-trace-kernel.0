Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC5819994F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437775; cv=none; b=BMxR5Zzx1HxRIizZ6AORoyp/WxHiYvL/Z1Ft+T6eOXfxBdpMAGOsWiLKbDPXBtdMb0ZajTfdvlnDA5mPxhiFiegvO6sb6LEiNvxbJnf/pzVZuJxZQaBwgkhUVrE1TSzdeXJO/jW3o2JYVL9edvXn9R915nskGtjhe2IkexcfiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437775; c=relaxed/simple;
	bh=CfKSu8kEhLEtBjpsl9nJNx19AXqVSlJZLla68r13dyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRpiwP2cGDh/eibYWOaY3PCxdMWtYv6JIfg20Cp7EF9NCy0EkSkzYHzelEcd4dKPWWxU7LS8YVLghZ1uY04XMpbHJ2MGvJcwBPilAyO9QARJbzMJyJ+LXuCnKA44vjU48rBcQCIASkbP3iWXjodg142eX9ADk/v2zteHqdsLDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qxftjo0R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qxftjo0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751437772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CfKSu8kEhLEtBjpsl9nJNx19AXqVSlJZLla68r13dyE=;
	b=Qxftjo0RlRi1N8ytpbpQb5rN+szNFW2ULC2vaI2mDha8csSHhsQjfSnPqFfl+RFi7m7rZE
	8XROWmm0msiVZ/1fBgEJZU2+QW5U3pEulFpXUV+vgbr63aP9qRjxf0v6MeKr8DYmVCB5wN
	moL1gd1HuGTVaqxUhT6n62mjywrNQ0Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-cfAbkaqAP3-u4VZYn3X0Jw-1; Wed, 02 Jul 2025 02:29:31 -0400
X-MC-Unique: cfAbkaqAP3-u4VZYn3X0Jw-1
X-Mimecast-MFC-AGG-ID: cfAbkaqAP3-u4VZYn3X0Jw_1751437770
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450eaae2934so29088045e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Jul 2025 23:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751437770; x=1752042570;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfKSu8kEhLEtBjpsl9nJNx19AXqVSlJZLla68r13dyE=;
        b=CpnZJE+3Dg3KqLkFGcbhlza907KC9tsqu+nIoykliT30lsp3ttseKW1YEds4EuW94Q
         LQqPa2QWnki1/jy96rEthtBgDcQ5dxdoDVIxq6bneR+KWv/sK+jl/YnARiZkcdgpN6iB
         bL3ZwniSLOPh4s9uFS2JOe/VHSoNDF2VjAjuvMUb0Pf8/p3kIkgIEhrnla5obtWuqa0Z
         JMoVzthZ9LTePJltVbNvReTgDrfMg0M2DBsOLxvmbuY/iuzhlq5aL8oD7fYfkNLN0CoJ
         apeCXK3OOACKFtuEV4Vljo8H6MTcrV6IHHZzznShY3Ve8qeyJ5cIQ4iivd6DTkhWreZx
         qrFg==
X-Gm-Message-State: AOJu0YynFYkKbIR7/7xzqZ1+Aj6P2gQjzTYwlnofTbQMijRhdcIHpySS
	GB5xboNNQELiUfRD0+YIt1FLzxDkuYD3Z4LQgSQSbZqx1TROQNd7hEZ2ZSn+9WbOLrKgsJYTao7
	RAuECO4hF8cuQtyYg3eawHaKVuOpvMmw+7EqcEyxHqwQpXcNX9/Bf1qLHnwMwlewxLOwXq56Nsd
	NP6OURyBnB
X-Gm-Gg: ASbGncuOnBD1T9a16bjdklEzruNJO3mg9ClYehL1iks+3x/OCOh9m/pJ2In6c+B1MR+
	VJbVXYcPjy1jbHp8tY2hXxbgAfsZ4DdwIuk/2UQjV1qy1qwn0s9wCERQCaafGEtdDv2B95f+UXz
	iVQxMjwqFj8CIZO4FbR+/fuakHeYSd3sABr+qIPUGtnqk6o09ZC/nU2/uGrkZVLFtTMiKBZX9k2
	90lgQXvQJUjLXEiOY+mLnHfe73OJLnl7qfSxO+JETYphkmLEkXQV1QLjeGCihOdqFNxj+0PcUSY
	MzTLSrnoghajV4nEU+MovMgIwZTNTdqMx8W4X1or3mQ8UfKZ
X-Received: by 2002:a05:600c:4f16:b0:453:86cc:739c with SMTP id 5b1f17b1804b1-454a36dd7b7mr15163795e9.1.1751437770373;
        Tue, 01 Jul 2025 23:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEynGfn8zWf+E+Vah2RMMvoHI+5K19PrvJWfShzG6FXGthFhaZImMS2EAvK/7nzYpn2VsAVag==
X-Received: by 2002:a05:600c:4f16:b0:453:86cc:739c with SMTP id 5b1f17b1804b1-454a36dd7b7mr15163605e9.1.1751437769983;
        Tue, 01 Jul 2025 23:29:29 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a390d55sm192574235e9.6.2025.07.01.23.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 23:29:29 -0700 (PDT)
Message-ID: <309ecabeacc72f13de7b190f37423f1aeafe991d.camel@redhat.com>
Subject: Re: [PATCH v10 17/19] rv: Add rtapp_sleep monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	john.ogness@linutronix.de
Date: Wed, 02 Jul 2025 08:29:28 +0200
In-Reply-To: <20250701171715.5a1a99a0@batman.local.home>
References: <cover.1749547399.git.namcao@linutronix.de>
		<d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
		<20250630203401.1a11e58f@gandalf.local.home>
		<20250701051757.mBjQVdoo@linutronix.de>
		<20250701110218.5e742850@batman.local.home>
		<20250701110551.5c2dc2ee@batman.local.home>
		<20250701151114.OJQTlRCY@linutronix.de>
		<20250701111704.00456667@batman.local.home>
		<20250701210338.BooVbo54@linutronix.de>
	 <20250701171715.5a1a99a0@batman.local.home>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ywjns-wrBsvXfDB-1OJGNhxwELcvAh5sN0Y42P6i12w_1751437770
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-07-01 at 17:17 -0400, Steven Rostedt wrote:
> On Tue, 1 Jul 2025 23:03:38 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> >=20
> > > Bonus points if it shows how it was generated so that people will
> > > know
> > > how to regenerate it.=C2=A0=20
> >=20
> > If it's okay, not in this series. It requires changes to the RV
> > core
> > script, and I prefer not touching things which are not LTL-specific
> > for
> > now, unless necessary. The DA monitors and the containers do not
> > have it as
> > well.
>=20
> Yeah, just update this set to state that this code was generated.
>=20
> >=20
> > Let me stash it into my TODO list of RV cleanups. I will add this
> > for LTL,
> > deterministic automaton and container in one go.
>=20

That's a good point, at the moment the DA monitors have a comment in
the /completely/ generated files (the automata header), the others
where just a skeleton is prepared have some hints that we removed while
filling the monitor.

I'd say for now it's good to just add a comment in the LTL header (like
Dot2k:fill_model_h_header), then we can adapt all generated files
(whether fully or not) to have also the actual command that generated
them starting from the model file.
Or did you have something different in mind, Nam?

Anyway this is all well documented, so pointing to the documentation
like we do in the header doesn't look bad to me.

Thanks,
Gabriele

