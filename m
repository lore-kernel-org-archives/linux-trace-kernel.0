Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC5BE4E
	for <linux-trace-kernel@vger.kernel.org>; Sat,  2 Dec 2023 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl3+7BsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0070C433CC
	for <linux-trace-kernel@vger.kernel.org>; Sat,  2 Dec 2023 06:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701500051;
	bh=4GSi6OT8Z/c7LHsP3xxBSy6fMBjXgVEy1+bdnjL0xgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gl3+7BsMgtbWPRe9wip6FiQgAVHy+GK1/FcSNR4JOItmOmDiT3UeIpdoBFB3oDFC/
	 fdM4liUCMuQCH2rwJcB2AuzvfzM9+8ZAwzOF/VnfpXoS/vg33NzDwfz4/Qa4D2Gs99
	 lI/aPGceHwM2p0c8QIcTCky4GG0mEBtVX9fK4QwaINYUJ7Anb+jRSAnku3H1rIJ0kS
	 9jsuEDUqJNMgrZO/3z5nfyUeVVG8BIEfkqgXp2y+Y6Rl0lYLjYPZXBsGdEUnhbv/WJ
	 ec7RnDdbZggs79gI9Vf+SRTXeUPyTtgvKfXM8xFw1z1klzED11pA3hkPxNLzkQZvVU
	 comUMOTU46rcQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50bc8a9503fso4010324e87.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 Dec 2023 22:54:11 -0800 (PST)
X-Gm-Message-State: AOJu0Yz7t4dD96RUeCrspUHcBLHKaMbWLjvr3pRyx1FQkoBDryLla22l
	oeuhWDCLcMf+uaUFoOLCtPTJ0U6zmZLXXin8U8c=
X-Google-Smtp-Source: AGHT+IF4Y6qCw08C5cPJo3xLm3SlVu5jtphGtdGtnPu70XfmT+RBquqe+JuJGwuvUgFxa97T+Hr0ZqPY/tbmRaPrFWo=
X-Received: by 2002:ac2:59c1:0:b0:50b:d764:882a with SMTP id
 x1-20020ac259c1000000b0050bd764882amr1443331lfn.118.1701500050048; Fri, 01
 Dec 2023 22:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
 <CAMj1kXGST7uH530hB0i-rzisNesNrUGsJ5a5eC9805Udi5msrQ@mail.gmail.com>
 <81af85b4-5274-4362-9413-890425c60524@broadcom.com> <20231201130702.2824115c@gandalf.local.home>
 <4597db06-dabc-4bb2-9f24-bd30e07ff86d@broadcom.com>
In-Reply-To: <4597db06-dabc-4bb2-9f24-bd30e07ff86d@broadcom.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 2 Dec 2023 07:53:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFMy0=DP3-Ycsj+XCHWxvqNqddBkEm71Nrr-m9gVca21w@mail.gmail.com>
Message-ID: <CAMj1kXFMy0=DP3-Ycsj+XCHWxvqNqddBkEm71Nrr-m9gVca21w@mail.gmail.com>
Subject: Re: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
To: Justin Chen <justin.chen@broadcom.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org, mark.rutland@arm.com, 
	linux@armlinux.org.uk, linux-trace-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger <doug.berger@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Dec 2023 at 23:59, Justin Chen <justin.chen@broadcom.com> wrote:
>
>
>
> On 12/1/23 10:07 AM, Steven Rostedt wrote:
> > On Fri, 1 Dec 2023 09:25:59 -0800
> > Justin Chen <justin.chen@broadcom.com> wrote:
> >
> >>> It appears the sub instruction at 0x6dd0 correctly accounts for the
> >>> extra 8 bytes, so the frame pointer is valid. So it is our assumption
> >>> that there are no gaps between the stack frames is invalid.
> >>
> >> Thanks for the assistance. The gap between the stack frame depends on
> >> the function. Most do not have a gap. Some have 8 (as shown above), some
> >> have 12. A single assumption here is not going to work. I'm having a
> >> hard time finding out the reasoning for this gap. I tried disabling a
> >> bunch of gcc flags as well as -O2 and the gap still exists.
> >
> > That code was originally added because of some strange things that gcc did
> > with mcount (for example, it made a copy of the stack frame that it passed
> > to mcount, where the function graph tracer replaced the copy of the return
> > stack making the shadow stack go out of sync and crash). This was very hard
> > to debug and I added this code to detect it if it happened again.
> >
> > Well it's been over a decade since that happened (2009).
> >
> >    71e308a239c09 ("function-graph: add stack frame test")
> >
> > I'm happy assuming that the compiler folks are aware of our tricks with
> > hijacking return calls and I don't expect it to happen again. We can just
> > rip out those checks. That is, if it's only causing false positives, I
> > don't think it's worth keeping around.
> >
> > Has it detected any real issues on the Arm platforms?
> >
> > -- Steve
>
> I am not familiar enough to make a call. But from my limited testing
> with ARM, I didn't see any issues. If you would like me to, I can submit
> a patch to remove the check entirely. Or maybe only disable it for ARM?
>

Please try the fix I proposed first.
