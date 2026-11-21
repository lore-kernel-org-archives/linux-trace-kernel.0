Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795221756;
	b=J18VzezxjXG2KOTGiGuVtF96lEvvFgkZ++b8PVMlG7jUJ1FEGeGCT2A9lusbUinc4kcD
	 rNYNGpr+k6eCO/urM0VgoNVITA/zvZ5qotdElhWjX+lj7SAHdObq2LeVcaTy8iLGgKQk/
	 wfpuYxKZT0XRsUiwSJ6SWnNZTR3SlukdX+5Qi7hf4cXvGVCi2TKhv5vyanANO+MWqwts1
	 Wjz1H7AhbEg0W6bcr7jO+ydM5X5qltr6LQj1rHHv3hcqWrIT2Unqvnkry6Ge0Wuqs1eOg
	 U0Ic+QHAXcuWhkykZtINexDgoQcBwPEdk81jqcezLUE3M5hxMg97U+uvZnZ6RqdAM/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795221756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Js5N6yiXwXXSTzZ4KgFGwIMSCZDX/tKTz1lwaDrh2ys=;
	b=efcXFXuU1vA+MJv84Zz9eUkxnduAbBKgJC9Xa/eCiNQB136g4Ted4+TmmWZGRMy3avrv
	 aT+fbxN1zPC9p1AxsORWvd7Q1GRcqLOpOYcyRPAjVyXmQS1lPz3gEX4fIslmpyhzc/vfL
	 uE18pl218W0vQ1w3QeHlud7rFTJsnUB1vre/tQfPKGmyuR6Nqse3+u9pKQqh67x07ZVI+
	 TcSNkm1oclX20OnPaPoyxrk15Jrnk+yzH49RiudgbH1Wocf7faJuphOTXLDb1S+XVdMjZ
	 PBh6QmCzuZ5E4sjrgYl48BHHsErl8AXei5giA1IkYI4Ex7GXLSMGb4nqKwEducNEotQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pD4AmFXt;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30905606A6BD
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 00:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30905606A6BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pD4AmFXt
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3863db981d4so1435074eec.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 16:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795221754; x=1795826554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Js5N6yiXwXXSTzZ4KgFGwIMSCZDX/tKTz1lwaDrh2ys=;
        b=pD4AmFXtEI4gcW8lq8jgkb4TQsgIV3/rLtjvPlKCyYdsJDnM+Zhcqgii1TYOrJgoEg
         68QH0SXg5hfk3V3UukH3TNA6omD4Miw35AKisfch3ZeCi1bcWUEFHWVhKQFBenR4d/uT
         PFVo9ZKRd8MNE9ce59HLBrRIZXQfzrDXwp88W6gcmp93e+7LmSWp/JUaImYP0bEpCPKk
         6tqgTgqxEcGLlucCXJv1PzuFx9Yqt9WPeGxHvVFuV+Jy7dSJmrRs5k1OvQWJzkVegXfk
         /o+CFNkY9vYecLaF55iDgXS/a0dzZuftjHafZCpoIZxy8MI8Lcx0nAf3II18bzFxbRtK
         7fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795221754; x=1795826554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Js5N6yiXwXXSTzZ4KgFGwIMSCZDX/tKTz1lwaDrh2ys=;
        b=HMv578cTHklMi2QXLmNOcUPX+QjTb26S8y5nFGAe8i4YCyuahe1yRFX3qEdwN0fv/M
         OJd6Jm09AvezJoJwc9w31IYXjsWoaH5jsAGJJRsleVy7JEEHFw0Na1DFueyg8gKut3lp
         UIKXKnSM0no+w9bs22JHMVH7eUcCjdoLitCckdZuE+UXx5ty3yHG7jsFOTSLouuiejtt
         PpzC7WOfMEZkbu+haOSk/8GRTdyPvWicq/HlLUT59mLm9hYLrYggTb41v0Jj9ruL8QZJ
         0vgpIIKmETMyRmabHajZZa4GWJknuL/8lp1qGnyaChv57XlxHj4R8EvO/5plyxyhbnvS
         8A8A==
X-Forwarded-Encrypted: i=1; AL+hErEJRE3nqqrfxMj8xj5peHdPP2fvMDISzGt/SIXWMpHzQwD3eLywUVRWHXi7od4fm1dLfm2w+xOiWjy35NykVAwXjvc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kPQLqhEmOsS/3Ob4RV9i5ogRxAtZreG4sslIZI3U2UY4PpeQq
	j25gdrcQ7YgjCwNqXsg+IyTUJe8cCRFItPhr5SZudkMTe0BCZ+FhDUG1
X-Gm-Gg: AZFdTZcxOWcnoTWqcIYgr5tingsVgdlZ8GKkL9e9JxLTON5S1HtOmPKOIHqRTqA4vnz
	K2I/ye9OYuWErZMngRBdYnX4Bbh1dqeQ4H4xGbC3qfegObBYTOTuT8Uyk11Hkra4+PeuUwITOgZ
	Rx0Zfi4Hez2P0pxPSotsh6/cI0WQ3mUqaFFEsZmWzIrwRzgpGhITZ+NRG1G/33FLYnRHGgZ1fHn
	Bu+fh/WVNj1kxsNBDWunxxFO28YGXlaymPURIN4Ri4fJs2BT/qF14EbyIU/BVCnqA9EvMMQBju8
	yGr/M8Qh4j14drYJxjlzNKWVzLp4FmC9RcH1ZZxlJoj3F/eM1Et4NT1Ppg04Vys8LwFl7ea4CMN
	1oLj3BbRZntT4meyD8mKZtIxBzrNUk/obUAUzulhw1UIi5CHfih0S4LVHswcl0N25B1x3irN8n+
	u8DFUnIxpT10wXP9NVYDh5w9UcvMDN0Z3HvQAKYPjKC1ZXXrP8rUoNGbK8t8oyyICi43IzZ7EsA
	ObLpAzr/cONcITu+pcbEzkL51Vcu4OlO1r+sWYu4mG9vP7ZoA5ZwhC5wsXoT4u/M1qxcnby3PT3
	sGyLbJnzq7K3S7q4GfMs3plfuReLjXd6Vw==
X-Received: by 2002:a05:693c:4091:b0:379:4197:5eef with SMTP id 5a478bee46e88-3856f65b3cfmr5387027eec.8.1795221754060;
        Fri, 20 Nov 2026 16:42:34 -0800 (PST)
Received: from localhost ([2408:840d:6820:1a1b:6def:d896:8796:4938])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm12699706eec.27.2026.11.20.16.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 16:42:33 -0800 (PST)
Date: Sat, 21 Nov 2026 08:42:28 +0800
From: Yao Yuan <yaoyuan0329os@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Yao Yuan <yaoyuan@linux.alibaba.com>, 
	Alex Williamson <alex@shazbot.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Lechner <dlechner@baylibre.com>, 
	Armin Wolf <W_Armin@gmx.de>, Thierry Reding <thierry.reding@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Marco Elver <elver@google.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Bradley Morgan <brads@mainlining.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Pnina Feder <pnina.feder@mobileye.com>, Mete Durlu <meted@linux.ibm.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Rio <rioo.tsukatsukii@gmail.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Longfang Liu <liulongfang@huawei.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Brett Creeley <brett.creeley@amd.com>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, 
	Julian Ruess <julianr@linux.ibm.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Eric Auger <eric.auger@redhat.com>, 
	Mostafa Saleh <smostafa@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, qat-linux@intel.com, virtualization@lists.linux.dev, 
	intel-xe@lists.freedesktop.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vfio: Allow untainted use of driver_override
Message-ID: <awDok7Sm5Dgp-Ty-@sapienza>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261118235645.2907908-2-alex@shazbot.org>
 <xzp5gljhburzbpol5bgnyyzwdrgpw3fj6ff3j23ein27raiidw@kti7moeuwvb5>
 <awBUG7-QzXplEiUT@monoceros>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awBUG7-QzXplEiUT@monoceros>

On Fri, Nov 20, 2026 at 03:10:38PM +0100, Uwe Kleine-König wrote:
> On Fri, Nov 20, 2026 at 10:17:46AM +0800, Yao Yuan wrote:
> > On Wed, Nov 18, 2026 at 04:56:44PM +0800, Alex Williamson wrote:
> > > Driver overrides are the standard mechanism for binding vfio drivers
> > > to devices.  With the introduction of the support_driver_override flag
> > > in the core driver struct, it's now required for drivers to declare
> > > themselves as driver_override compatible, otherwise driver_override
> > > bindings will be denied or generate a kernel taint.
> > >
> >
> > Hi Alex,
> >
> > > Set the support_driver_override flag on the driver struct across all
> > > vfio drivers.
> >
> > LGTM.
> >
> > Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
>

Hi Uwe,

> I missed your reply when I sent the next revision of this patch. I had

Thanks for your reminder, no big deal to me.
Let me follow your link to have a look on v2 there :-)

> to trim the recipients of the v2 because gmail refused to send it with
> everyone on Cc: who was emitted by get_maintainer.pl. So please see
> https://lore.kernel.org/kvm/fb0df5c89336b77a373ae0f890f63427e4adbb28.1795171088.git.u.kleine-koenig@baylibre.com
>
> But also note, that if v2 is picked up using `b4 am`, your Reviewed-by:
> is considered as the patch didn't change.


>
> Best regards
> Uwe
