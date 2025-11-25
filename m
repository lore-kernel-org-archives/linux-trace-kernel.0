Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1B3C38
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092137; cv=none; b=O1yfovQ3bR2VaGDM2M62mE975uGUIOgTt+rZL9Joi5mjZza3L5gjxc+Ph74aD7eNsNpXDuFnQ0Naugj7bdF05+ppVF3EAINFHczmk0bvCWSfTAOahz+qKIklBGfSB2RSXPJXk5sB0SlqeaCWLxjLJbR6TRQazFAPCHRC2VgChs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092137; c=relaxed/simple;
	bh=ZJRD93ay2tdPE4YsyhohM/u8pTl4h+slwsZ1hHGrZ9w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W92X+Xbkj8fsHYsuu/zTxR96lOPn1Au26Ci1NfDt2sRAaWsskAsMajcOsl0r8Vy6NrmP++ifJXieIZqs2M5DipkdT2GRLQr8pWikYAOhNDyuh5tA8Kh8Kiodpcu8GRmYz7UHTiXt0Bda6BmXy1jin/sdwY5WB5GnBuxvgfHekVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaxTTZVN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaxTTZVN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764092134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zNoltlboUskJRQ3bOMiSb7Jg1xFgwMkPeBsE8D53FQ=;
	b=MaxTTZVNZL1h4eUxon3XTeoRo5GNd4J2iQ6OIS4mh+NtpaQEYOjh5jQyQOpo7ZHjEYdL0i
	fEqGAeCz8IbTn72Iie0UWZPXr/8z8ROlVG7D5Bna55hhqUO2hnGwpnNa7tVIXxZZYVBmqm
	X4fwWX5zKW4W34/R8CZH+emgKx/fMBA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-YJde7Tn3MgedwOG_CrTGMg-1; Tue, 25 Nov 2025 12:35:32 -0500
X-MC-Unique: YJde7Tn3MgedwOG_CrTGMg-1
X-Mimecast-MFC-AGG-ID: YJde7Tn3MgedwOG_CrTGMg_1764092132
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9487904aeccso1969639f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 09:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764092132; x=1764696932;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zNoltlboUskJRQ3bOMiSb7Jg1xFgwMkPeBsE8D53FQ=;
        b=XYh6jcyNMCPhoU/ytvlH7Iukytmtr6Q70pu1FAzXYhJtWmwXY49yPneVYanxPCrlzX
         pLOO93LhlnbYN/JNVYGc7qiF2xtcFcQ/+GL5/zn/eo1u9D8rHYRrrFW8FHZsn1Edw9iz
         4r6yuWNq/6zqv7ktYGBX6p2qQhFbKjBwdEfU4KWbxiQmPyhghudl8liPJ+NkpsbbLC5W
         4WG/xKK3WuyE+t5QeXPofUHiaJgR7VA1Z7bNDfmqLNrT/lMoijumyAM8iE/1agJLp/WW
         wRAJIrxuRJL/pqz3+kjpt8FY1QGyM6KxJ5KWB28lsn5hRstu0QfCAOuTCAOGshraquim
         jEnw==
X-Forwarded-Encrypted: i=1; AJvYcCWjJYT+HRdsepxdz4wWW56yoPNZX7EJEvZnVJdwjgazEbCMT2Nu53mro1XQc/NpLiWrnOrZ8yarsRPd2IFMjzkmaY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMChz1xpGZSjVQhsqzWzTBlgw2bLqMAtf6mJbuVtFG/rZDibTx
	/Rdnql8kWQucqKEBqooHTPYyiSAJEbBIWbDETM216LnoWPJv7CoYo0mze6v8hcPKtTIsnmO9L94
	mc9fGIxToDDLt5KtEcFmEjTKq4prWZEcB2ZvTpP9GgC/BXjKNWqKYJORxSEhjHcbj4qJYJiVJng
	==
X-Gm-Gg: ASbGncukdu2OYAcNvoj1kTUHDWGrQAa0ZXgMFdlwuoSr86OW5q+kNW1arkU6USHXDV5
	sl8GQvkatjEZ52hFBoY9UBHC6fnIMlm2T8cMzpstSyWPmtO2tRNVZ5B1RAq5eUf0PjvKMpQV/Ma
	Tik/r3gx49EXiTvm8j+6PrjvTvHzWRxSON2z0nYbqwfbZMmIA96bu2OscIn7FItpWuFfnE1jQLc
	SFPe27JPTN+Xyrfh21zDvInPCcuQHNZ03fahBDvZqCa8TLeJicWmb1WN0fvmB0Z10MSBj0YE/mj
	xpm0FMdNRXtT8kYNI3LqZLxa1nFY7DQW47pYoLxK660DygZ7yD1Wg9+DK9jGOO5rfVr0UdEmUDt
	iuuOUPc82UPxNzSaAdCG610UHlto=
X-Received: by 2002:a05:6e02:164b:b0:433:794c:8486 with SMTP id e9e14a558f8ab-435b903285emr154304695ab.2.1764092132063;
        Tue, 25 Nov 2025 09:35:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQpEaWyvqTxiWt6WF7K+P/ZxKH4Z0wrrwRwjmou3enox+OlV+PF9m82sbkyvSiX7SS8Gv+PA==
X-Received: by 2002:a05:6e02:164b:b0:433:794c:8486 with SMTP id e9e14a558f8ab-435b903285emr154304505ab.2.1764092131768;
        Tue, 25 Nov 2025 09:35:31 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a9056bdasm77369065ab.4.2025.11.25.09.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 09:35:31 -0800 (PST)
Message-ID: <99c2109dd8c4b65be34f5ee00575a267da10b002.camel@redhat.com>
Subject: Re: [rtla 07/13] rtla: Introduce timerlat_restart() helper
From: Crystal Wood <crwood@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
  Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur
 <jkacur@redhat.com>, Costa Shulyupin	 <costa.shul@redhat.com>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, "open list:Real-time Linux Analysis (RTLA) tools"
	 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)"	 <bpf@vger.kernel.org>
Date: Tue, 25 Nov 2025 11:35:30 -0600
In-Reply-To: <CAAq0SUn=eK+9YZZhdL_bs0S2cfVMhuuV-v8DSRMkTOqoL=SEWA@mail.gmail.com>
References: <20251117184409.42831-1-wander@redhat.com>
	 <20251117184409.42831-8-wander@redhat.com>
	 <fb5b468b38ac9570a5f3fb948452d1b5b03c9f9c.camel@redhat.com>
	 <CAAq0SUn=eK+9YZZhdL_bs0S2cfVMhuuV-v8DSRMkTOqoL=SEWA@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 65jcLRknBvd3h17jR2sczUvUsmFIQFnH5XAKqciTjss_1764092132
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-11-25 at 11:20 -0300, Wander Lairson Costa wrote:
> On Mon, Nov 24, 2025 at 9:46=E2=80=AFPM Crystal Wood <crwood@redhat.com> =
wrote:
> >=20
> > On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:
>=20
> > > +
> > > +                     if (timerlat_bpf_restart_tracing()) {
> > > +                             err_msg("Error restarting BPF trace\n")=
;
> > > +                             return -1;
> > > +                     }
> >=20
> > [insert rant about not being able to use exceptions in userspace code i=
n
> > the year 2025]
> >=20
>=20
> I actually find exceptions an anti-pattern. Modern languages like Zig,
> Go and Rust came back to error returning.

Maybe I'm behind the times, but I see exceptions and error returns as
complementary... not everything should be an exception and I can
certainly see how they could be overused in an anti-pattern way, but
they're nice for getting useful information out rather than "something
failed" without having to add a bunch of debug prints.

-Crystal

