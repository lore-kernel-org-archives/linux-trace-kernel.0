Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DBC379EE7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087728; cv=none; b=htfYZiWMYT10L/YEHSM4f6qc9duduB+uDz+W4kUmMEnjVvI/NVm3Nv6aSZ7vMFmFGTJcYhz03U8FnGviCtBENNsmMMmNuNylgD2PY2VEMYjQMBN6qch0ztoy1cIRWZnoDqzqAZZplrE2CMmonrJNN6CmcAdePwQTRTK0MFVQBuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087728; c=relaxed/simple;
	bh=NEyIVmq/MepCR0DVp6TI3+6kKc1aiUn/+ROhgJ5gksg=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Av76cJKVv0VB2E8/InvX2jKp/yhdPXS8CiQ73fPzJzUw2IAPaQT+5dWSNtXZ24lYILeZp5gMWKswQCQ1OuAffeDravyouFMYHuTSstKYBJsAEsXBgpma9t0J0oUaWk/QLl07fziTWhQBcdkXG8Dwh/QM0LNmmUgG8TyuE3HPz3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbNcnKpX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbNcnKpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790087725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gK1S9WSj9Xr3eZwZT3BugPd4DtS8wZ7bJxT3IFUTmCk=;
	b=YbNcnKpXkQCzeYPQRLp76xmekPlNplIhoaMjzoDqxnhXWheywLE7UoKf05Ncmvxq6Qq4qZ
	ykShcN9ajRGFzeLHeGmgiq7pLZKzxZVQYb98RAzAHh8gepZ7iG/NPvdTfOXXV2mCg2eA1z
	ei2GDRISRIVeamLifupRYvb3jilgZL4=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-4_JOtQvoPIqyGaXelfBmMw-1; Tue, 22 Sep 2026 10:35:24 -0400
X-MC-Unique: 4_JOtQvoPIqyGaXelfBmMw-1
X-Mimecast-MFC-AGG-ID: 4_JOtQvoPIqyGaXelfBmMw_1790087724
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-791463ed29dso3774482137.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 07:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087724; x=1790692524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:in-reply-to:mime-version:references:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gK1S9WSj9Xr3eZwZT3BugPd4DtS8wZ7bJxT3IFUTmCk=;
        b=0AQeiS+Cg3CiMDuEcVT/z4pFNfpk1+sOghBrEVWG+KJJ766e6ulJgES1ZeohZdG1GF
         LV47jt6x1DxViYMK9d7L6kJ3SFtFc/i1JJ5qYxIg7EZ414UTfZ6BjUwrqLym1N7Vnhx8
         dBb5WhBu0JtK68HS6Xmh7aTMsErBNQiSEd2FiaEy0F/yn7vki+MyE42shdXuLmNvW2T4
         7j7oTd1JMeghuyfDqrQw9jv7ddWIlooyrzmiZwbLxk0tGvcBlm4+FN1dcUk3D5X67YBD
         7xJtIcuZO9xsIfF46RyC9bV0avntn68rMvDs+3bHGx42mFDs6YkT5WjOEpQkEEGkXVkY
         u24Q==
X-Forwarded-Encrypted: i=1; AKwUvBzP8mvhoSdm3EgkeZras7u22lf1Cy9GNE2abf8343ObzZ+iwNu7fg3bsY7X59V7CCImXow8/xAysRZkjf7yU5rNA5g=@vger.kernel.org
X-Gm-Message-State: AFuF++nVeRh55ohn1P865dErI3b0FXGMI0ogf3MdSWw/bq7uIzwghXWG
	5XEWMyRlWc/u86kVF6fKREdZreFVgCg3Wg7tlb8Ge0NL5EnMBQtziRIxZHRCuVWg7Tpv9QjHefZ
	FaShoWjCsaSJXPcD3RLe7fDtyLdYhIyAQPoDHlzClNgRkvM1OXsrUHpFVlCnhn7DmC4QAQ9rF9Q
	dJqoCTJQzf9ZDF0DOHfr26zFbZjN8L0NJNyhLBkSbL3lg1foDu
X-Gm-Gg: AYBFou1TGOYJjkPYCkzKE7PcPNbEVl82SniTWPUJ/OITegIO8NZsu8VamCGHwHJ1+De
	9XpwSYLNDtB4xSEWnfHqUQjddBYE8pChgD0hWKE0YMAA2i5n5oVlko3XFNy5NMTaB7i3t8ehudb
	XZ6RT86lzk4GkvZA2oBIa33p+RFabwvDoz8/NHlua/3j8bb2cTaVokDj4=
X-Received: by 2002:a05:6102:6b0a:b0:7a8:1817:2765 with SMTP id ada2fe7eead31-7a8181728f4mr5384420137.11.1790087718424;
        Tue, 22 Sep 2026 07:35:18 -0700 (PDT)
X-Received: by 2002:a05:6102:6b0a:b0:7a8:1817:2765 with SMTP id
 ada2fe7eead31-7a8181728f4mr5383871137.11.1790087714634; Tue, 22 Sep 2026
 07:35:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 07:35:12 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 07:35:11 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
 <20260921101538.97286-9-johannes@sipsolutions.net> <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
 <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
Date: Tue, 22 Sep 2026 07:35:11 -0700
X-Gm-Features: AcwNN1XMie8kM7dwxvbQlHH_l7IaHZoq1hw6XOWcr3XDlRFXqBgXY5EO4nZl-zk
Message-ID: <CAG=2xmNURzYdR+eL8x_kW64Bo9gEe3ne88YXaKQKT+_Ya7XZFQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Johannes Berg <johannes.berg@intel.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, dev@openvswitch.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Antoine Tenart <atenart@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fQPxpBxgyK0DWsEiUNm5kzTvvnviU25oPSvEfwJBVwg_1790087724
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:23:55AM +0200, Ilya Maximets wrote:
> On 9/22/26 12:03 AM, Matthieu Baerts wrote:
> > Hi Johannes,
> >
> > (+Cc openvswitch devs)
> >
> > On 21/09/2026 12:06, Johannes Berg wrote:
> >> From: Johannes Berg <johannes.berg@intel.com>
> >>
> >> The __print_symbolic() could only ever print the core
> >> drop reasons, since that's the way the infrastructure
> >> works. Now that we have __print_sym() with all the
> >> advantages mentioned in that commit, convert to that
> >> and get all the drop reasons from all subsystems. As
> >> we already have a list of them, that's really easy.
> >>
> >> This is a little bit of .text (~100 bytes in my build)
> >> and saves a lot of .data (~17k).
> > Thank you for working on that! But it looks like it breaks the
> > openvswitch test:
> >
> > https://netdev-ctrl.bots.linux.dev/logview.html?f=3D%2Flogs%2Fvmksft%2F=
net%2Fresults%2F833743%2F9-openvswitch-sh%2Fstdout#L168
> >
> > Maybe the test needs to be adapted to get the same info differently?
> > (and adding CONFIG_TRACEPOINTS to the selftest config file)
> The parsing in the test will definitely need to be updated, i.e.,
> the numbers swapped with the names of the drop reasons.
>
> IIUC, this change only affects the printing and doesn't affect debugging
> tools like retis that attempt to surface the drop reasons.  But, maybe
> Adrian and Antoine (CCed) may want to have a glance as well.
>

I don't think this will affect retis in a bad way. We collect the list
of drop reasons by inspecting the BTF enums. It generally works but we
need to keep track of new subsystems enums being added so a
dynamically-generated full-list of drop reasons is interesting.

IIUC, the only way for userspace to read this list is by looking at the
event format and parse the printf line, right? Any ideas to make this
more machine-friendly?

Thanks
--
Adri=C3=A1n

