Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040200;
	b=q01yRW6PxBPCMET/in3EJKdSu9i4S0ZEkn3WmtIyMTiljYF15PS8T6ve6IZTogtrnX2D
	 d3r++kV6i7Io3SrWT5icpyzCZROdWgQJH1+RVmlweYxRU5AJCQUiohyESFzjg774cHaF2
	 Fg/HbGxgEdtwWeHcj065SMYqOefidXWNjmKDkYIrHBEQpwYezgAtzIOIaJCu4DdMx09NL
	 XUdl+ky9gXPSV7B4Dob4Gw+i5YWw56bFUeUQEJOJS3POkjl5Ma4UZ9jWNagY1nW+16fsL
	 c/njJ6zUQAnKJYvgRXZuijwCDvZXsKHApoMauo7sr96MT4Vod6EN2WSeqJ/Ic4tQ4FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZWci1OY37Q98PjNDa+DsqfD5q79/im0Ez6T5Vupv1s4=;
	b=giM9LjxwvE/t/fLIYONsl4CIZPP5uurQLh8TtAq8PKuAzNzp5tzqL88o/T5Ussym3dzX
	 4zPlnlw47YLvlGnYkpMB3KLeenkKRDMO0raBJ/2yXfGv1VN6mILJuElvbblOUqxtPKUcF
	 nXCxGYnZlMlfTXYmjUDbmjqCLk14UxpfozzOB++XZ8NUm5XDgyHzquR0NmZLNKStpXi30
	 MlcYLZcvlHhTREPGMhSU8xUc58ZEAbQ++FgVjwAK4dEjx0XI7k2TQvRcyQm1VcuXXmZeE
	 cyN7ErjFkGH2gsaqt0aSkBRPZ0vv984/cFDDkz7yzdnbBHclC0FViblfKiMIIUMH++A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45571606A322
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 18:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45571606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-943e8d35f74so94699085a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793040194; x=1793644994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZWci1OY37Q98PjNDa+DsqfD5q79/im0Ez6T5Vupv1s4=;
        b=azZPsctqXRKqpOwzOSUanbXvvxd+v2oxaACaz4naHK4U/NBQWTZSH1+8VRwPrLVwY0
         DocnyrGmPyv8LQRxTMk4K4sAlQVJBR98rqP+2aWoEAiU0n2xJtP2lXe11PdsBX9zw7zH
         rykKuo4jE8Sw3g1ZHf1cUaz2vGbXwYAs98RHcsf375OaxpJvYYqyPF71AEMIeOtk1CIf
         vDE/ajmi0uLVqaMusVBTVkVR8NUGi0AybkTdqBwAenvqpPLeBFRcUdif9SgXW44+UVBP
         XcslWkg4kCuQnmXySZ0RwdZ8wSe243a/pyuPpY5dxc6Pr/hlCqlSwaLgYcUdwFY6ZPLq
         p4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793040194; x=1793644994;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZWci1OY37Q98PjNDa+DsqfD5q79/im0Ez6T5Vupv1s4=;
        b=F5k2Tr59Xaani6zIgEn+xO2Sy4uddVkdQIk/jnOzdY+r6TCbTLuq4jebYVQXsylhLQ
         E+zyU0uDLhzQQ6NTWMweosnPRD6bjsb+pQ1U9EsAuwILDTZHjkL7SQanbsboINSOuLAM
         sFVj382auz6q97spVjBi3+vge2YZWLJVy8EVqDIo6myBRacYUdAKbrnoq21oVgqXoSEc
         mI4bslZA1kjSYr5JlN8NsZEE87pAwfM9FBkI+uMeZ3dy/TZhoY0CsIK023vZwP8OztYu
         zBtgmqeO/UIWl6fDoOQ08M5fga+O4hzgWNu5L7AoC0UA3aqtcgwruRhMoN95zzqzsLTS
         hklQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqy3nlcYTEJSJd9uhbBCRM/iLx9kr624K9qA6XpTMdoZ9GgfXihj/vq1RJPzkS76NTCIrI9rUDgckTf77AXKGi/2A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfPfxDWUUgzQeDrZpfd0Sg5CMxPsCwre58ffy1xC4j5cliZrMY
	I57tiaQ5z65aZr8iNFG1NaU8KUkov0RSd51UH5ctIMzMQIy/+WkW0kuDr4CSBiGigJg=
X-Gm-Gg: AYBFou2XKODgT/BW2jbCVY4mnVoe8JQ5+cPR/G3JXR74c7GJJcfgy1wyCfeZLw78NoG
	QIxtbfO/kwK6QiAZ8PXMNnPQQfdWNcYcyUuSELFjno643aJQEoi8QgKGYOghxPjXVJICaXUksxK
	oDZx3W50+St6tNymuN0Z2YrfcZL/qFh6g/2OVZmgirc2QJngcWUvadKZJ8kKN2CihV7rv/Rc/tM
	3f1LaOBxhPrSu7MjDKcN4tEbDzux0NFEbl9gQLFBWJaY+D88T6FxsSejoNWDlwC7yLPD9DiNaWi
	KV6/I7JX2GnjiuKOR77VFij0Bgt5vKzecBtXGn5uOujKMTZrqiAKco/ZqOqokcd66dF3eBO0xgR
	0QWUT5aOGj/1FD3XuUw8uoY73KzqdGw7zpH49X6zW7wLHpw4UG3a+Fe4m60Rs8iJw9KOfVI2WZi
	d2qYmw9TlYgU++rS6VzagXD244VQiLBILuupEYdkGVD/CEgM3ARJCHN9A1hO1m1NaHYaLlpn12T
	yDQkBBpQsxUbu68t1HhW2uZU2Qszeyy48chFX1yUf4tANAWIRKgceUqtj2Bb6ib1/iMKp7pQ9oS
	uqMVUk3hkVqvqVn8maJeTAwj4irvAYRABO9czQRp/u5gBNKQEy5maV0z6SsrfIOrYtIlXBw7EVU
	QxnTPfJYbgvE=
X-Received: by 2002:a05:620a:172a:b0:939:6c31:2318 with SMTP id af79cd13be357-940ef8d8389mr1233127985a.34.1793040193950;
        Mon, 26 Oct 2026 11:43:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f067c879sm758709385a.16.2026.10.26.11.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:43:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLPf6-00000007foP-2hO4;
	Mon, 26 Oct 2026 15:43:12 -0300
Date: Mon, 26 Oct 2026 15:43:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Bradley Morgan <brads@mainlining.org>,
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Thierry Reding <thierry.reding@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261026184312.GA1685504@ziepe.ca>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <20261026122243.GA28851@unreal>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026122243.GA28851@unreal>

On Mon, Oct 26, 2026 at 02:22:43PM +0200, Leon Romanovsky wrote:

> This is needed for two reasons: to save hardware and software resources
> when creating a large number of VFs, and to allow the PCI config space to
> be configured *before* the driver starts using it.
> 
> There is no in-kernel alternative.

Having userspace involved in driver binding has also always been the
plan for confidential computing needs. We cannot have a device driver
bound across some of the HW transitions like TDISP shared/private, so
there has always been an expectation of bind/unbind.

For this case the existing sysf drivers_probe is good enough for bind,
but we must have taint-free unbind for PCI devices too.

I think this patch should be reverted ASAP, it is a pretty major
regression for a lot of users.

Jason
