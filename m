Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5CE33ADAD
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301284; cv=none; b=G5ZvNd8z4dFBxDddxDFeqPDaee4kRUcOAbC6ruzqTIg16b0djS7NINzgQBmmhXLRze40tXsBoL6MmGFnwXeceBD9GPsfnO880MbI8Uru2g+hMoyqtDipUtwcfKUnCLs/LiU5hQY7ZDFu5uCeFYBoIpoW4UXGfKJH63JXxnhZTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301284; c=relaxed/simple;
	bh=7rmNalGmd7Fwcj7GlFU39em2V1c7J5qnPQxFsrHv7Dg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPnBczSj2IiortRrhU6pTiE8WCt6RNg80zky2hTGsc/6UYTJDSqaELQbY4S03pqQqhxlZFNEIeepgvJ2QybgjxEXQFbfQiuelYANooijW1c6HhSXk1F0T4lsgkT7M0Q587sc2cTDVBtuz5KtiME5bSRdA7/jFP/HCNTrrUIpD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwY8q7Df; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwY8q7Df"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780301281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rmNalGmd7Fwcj7GlFU39em2V1c7J5qnPQxFsrHv7Dg=;
	b=fwY8q7DfMNhuexBy3HbWaeHxLhm/VNUAMdA7Ic3f8C0Z2DVlInHC+7NmrEJk9uqE5AdMBR
	3TCBD3t6tsy/nheHY80FAM0XUGBBq5HrWPO4I+boy1b3QIcZEAYBc6LbhN+PeR1rFw4tqo
	QCMx7NLxdYhX2snOrAnfT4spbstPESs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-einFF2q8MTKdNdXysS0-Aw-1; Mon, 01 Jun 2026 04:07:55 -0400
X-MC-Unique: einFF2q8MTKdNdXysS0-Aw-1
X-Mimecast-MFC-AGG-ID: einFF2q8MTKdNdXysS0-Aw_1780301274
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so78231855e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jun 2026 01:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780301274; x=1780906074;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rmNalGmd7Fwcj7GlFU39em2V1c7J5qnPQxFsrHv7Dg=;
        b=AWxHCQ1E/AdxZOuVm04YK15g8dVLUShBNeIBKBXjNEXCH6N10xYCxz/z5CFqxWin1p
         53FLijWVDGJaeCbvJpbXnNa5qx/0gWVlkir+2iWQD4FhxyAkBqMOFaahbDEE5nJPNB/G
         6LckqNsba9Qv+3QmZ6VmX16LTbTFvUSeHJj07pLO3lyuKF6ZjR9DF1yBjVd8lGAh699y
         74Z/nJ7m+d60bmXlHP5peT0s2Ye4jtEBmvSDwBfyNz6sfhAS+HfEZfiJ55u4kSUMjmWv
         KWCYlX0YqDUr5baeOe/dLZFe7J0uhZz4c2qZ8VG/sZPo/bbX08dX68L5XtMGBi63sVB3
         L1Fw==
X-Forwarded-Encrypted: i=1; AFNElJ8/8whkT0I4Hma8ePG6yC72V+rAtaER5Z+I+gmggzRg2ibJVuBj2ZiqRNylCAo0wnZpi9Mk3qY2z+9A6ISTiY0ootA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyub6TxLdpdsKk7qaqVHXc/w1AZALAfHMEW/LyaudIXlfoWFT9M
	PfuOI+68xGeRZx4De0d6Ztn/fZ2fkCKhbXa3tJjc0VY5KjcMUACE7eDCS6gN1YBtWDqU76bLZoa
	c3cVJ6Z1ToT4MCBkhm9br+VCwuhyTxQRjkk7wCpUf6XtANeNITgFqfpdB2MJijeEPBMEXLA/ebQ
	==
X-Gm-Gg: Acq92OHnGprrnEtMD4Om4NZQV9CNoXSnbenpctKAl5LWlU2p3P5rk7qJ8jOXsEzBM5S
	/4OW6ZH7VjgAHGBk4gOKI2P/mR2wh9QbJYuVepdHB+watP50GsBHGvcJWRdB5f2n7ga9ulZ8wZ9
	dgl8XaIL8zYyOBGiI4HxOH87FE/EA1qKaQ+rgyTsXhLAoCGVJU7wKXCPOlQ8DyvzSYaPdH/FqJ3
	WWEY57S7KGywfJhJX0BY0az3rC5NxNkOBOlnkK0AsrQHxQlPkjC3IEFBOC8GV1ZwOfmx2XSxZf3
	eYFxjYkA0A5KR7jMiyBeMe9kPGMWbgPPmLvSWnaKfmttwHBNTlCyd6+p2kh3z3wmTinhWGJ1QAN
	6DUp1zMfkShD+7SVBLsODpeCol0x+G+MG2URB
X-Received: by 2002:a05:600d:6413:20b0:490:890a:da46 with SMTP id 5b1f17b1804b1-490a292a4b7mr137676895e9.2.1780301273806;
        Mon, 01 Jun 2026 01:07:53 -0700 (PDT)
X-Received: by 2002:a05:600d:6413:20b0:490:890a:da46 with SMTP id 5b1f17b1804b1-490a292a4b7mr137676275e9.2.1780301273459;
        Mon, 01 Jun 2026 01:07:53 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm24054966f8f.35.2026.06.01.01.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:07:52 -0700 (PDT)
Message-ID: <0de9778e529af5561336588c651b3a59c69a17ff.camel@redhat.com>
Subject: Re: [PATCH v3 06/13] rv: Do not rely on clean monitor when
 initialising HA
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org, Steven
 Rostedt	 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org
Date: Mon, 01 Jun 2026 10:07:52 +0200
In-Reply-To: <87a4teyavy.fsf@yellow.woof>
References: <20260530141652.58084-1-gmonaco@redhat.com>
	 <20260530141652.58084-7-gmonaco@redhat.com> <87fr36yb7g.fsf@yellow.woof>
	 <87a4teyavy.fsf@yellow.woof>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rcZODFqPjQN0FJCrWwxbTzuOEU1mJO9GuRWwwmKJsPA_1780301274
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 09:31 +0200, Nam Cao wrote:
> Nam Cao <namcao@linutronix.de> writes:
> > Gabriele Monaco <gmonaco@redhat.com> writes:
> > > +static bool ha_mon_initializing;
> >=20
> > The global variable makes me a bit uncomfortable (a quick google
> > will tell why this is not the best pattern).
> >=20
> > I am sure there are better ways to differentiate when we are
> > initializing vs destroying. How about the incomplete sketch below?
> > I doubt it even builds, just give an idea.
>=20
> Or instead of function pointer, we can also pass a bool flag whether
> the timer should be reset.

Good point, we could probably do a bit better than the current in
separating initialisation and destruction/reaction. I'm going to have a
thought.
We are also protecting against tasks where the monitor never started,
so they never got initialised before destruction. This makes it harder
to distinguish.

One thing to note is that we should probably keep the reset signature
constant as that's a member in struct rv_monitor. But that's probably
not a big issue.

Thanks,
Gabriele

