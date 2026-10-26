Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055593;
	b=OEtVcZgkFLNuuctYIq8zIbGg1M0jr3o0lqCPB+N1c2sszQ0eU8DMzQLwg4fdNky82Khv
	 1ams6OQMrBqABYzXZZkTmzjvZ7udqV0UgRTpUqR4yXjjzkBHDbW1u84FKWLrXNyutCsim
	 xGk49Bb/Z5yOXWBusLtuH79+y+AsNc/BlWVWc2a7ojuJxQEHFGaW1ozjpkB9qhTUbx+ne
	 j6FALY37iwYgEGj1wbh8VWZxkBTXqc4et5Opoze25aUupqva0ysrjCCbjkpNal0G+VOi4
	 yepJ9pzNF9ScVH5zIc+We91D96E0kr7Vp69MYbNRWOuIgR4+RUZyaKu0xFMhwijTD7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=xYFlSdYSBy4efBRscq6PIWjy+kL+seLzZByRLeIBFMw=;
	b=LhxsvNRQ307HrIp7gupfeG+KD3KpPprTlgYNXdjA32GLNqyWtpRKKc005scX1V9o19tI
	 eXU+x6LGkRYaD8N3Zf7Rj4ZeAoY1fxLp/DpxTpDnrc7xmMNQAxres5Wlm7gz/QInTs5ye
	 ZJ6DLrgMzPTxn5OnWVKerDp2wjV1A4/b9bHgSHZm203WFOD9YhNcE6t6zra5+9+/IJ4Ow
	 hO4Agdl/C9lZ4BG7KOxirDi3y26YZVAaTc7vZsq3E14sz8ftv/2tW5jwkR8W1EBsWpGR6
	 wDCGRYIZgpfpLOzgG8t+VZ1CnZgMPli8wn95UMk9wFFOAeEDVcU4vviTSr0dZMC9yeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JtgX6t4H;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A31606A322
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 22:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16A31606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JtgX6t4H
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53394bffe0fso3906031cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 15:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793055592; x=1793660392; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYFlSdYSBy4efBRscq6PIWjy+kL+seLzZByRLeIBFMw=;
        b=JtgX6t4HkHHesY7n2JQPJyp+pm6/msV+LFkLCJeK62zQwbPs2o0eO3GuMpiwLyNqUP
         WdbCdxG4OXTrmFVlJcvkBmXQ9YK0s18xT86CS06J9aePaF02lGMjkyV+i9+s8AUyZYEo
         sVBYaHLO/lJaW0Nf3fxwP9S6DP4jpS3e3B7HPfWGx8noGECoZeSPzRqN8XrpE4+O7Hd6
         nE+g5KgftytnmNVxGTrNW812PMJZKe7xsMJRVS1IsYJ+7VcaMIV2Aq2Mx2fYBPvmFlNB
         KVI3wubDsUSR0XMK4VovCsCi/Ayb1GFD6RmHsKOHAd50F1EKGy7VTJQkptwcIKutBLP3
         4sVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793055592; x=1793660392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xYFlSdYSBy4efBRscq6PIWjy+kL+seLzZByRLeIBFMw=;
        b=08DnEkCx8wT7aj0rlNzb7CmziAbkWEXXaw+L+YOwjHCOvq3pjbImVnSScAcp/x7o8Y
         I7kaMj0LRRq06xMOpN59w8v+EaQ79XIh2DDCkLQs4uQ5ZWJGuZ9/fuzJRrLSWMF0VKvA
         XUqdiOYRaDzXkE0bCZsq0uNxeQ2rRtShwNFBws3A/8T9BMId2qV1BGq9fgpras3iQQPR
         geCp33rXBwPr+Y/aNlmAn4uHq4Vr7bnGNEoLrTXl8qwz9t7o9B9BWXRCYSh8LTbEGtRn
         0dmLfGpQ0LhfgRFTWyE+K7WoMw268l/phr4HXCVPHKLCHns4kadXvwYWXH8aLbb+9vNR
         elrA==
X-Forwarded-Encrypted: i=1; AKwUvBwxGDFUZL2qxzKMKM5+mu2hbjIzFUjMjBnWCCFwyhNWHBcGvKhhA+n/hyHbjwdZEbirkkj+PQFTuNJJrCQJchmXK80=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBwuMOKR5Ydv2oy+eyK8i/sAXE/c+BeebHWrb1I35i0on35jj3
	ndUNccm+E3LO1rKCUEtYCFXbT7wIFSfVPuq1/mxJjhmvDLeTDrJkAHv3CSDisPMwVtE=
X-Gm-Gg: AYBFou3ed3iW3hfzDVlV6k4L0Iq1gp7VNxlj9XIBXFqDCi8iEO9WaHLW5aRDcHkwF2c
	j7LcaOCKTYlVggVGmv0Pk7CYlWmA0jQ/8kgA7v2JPObHkLjDnRgdEbDqo5WAvR20U6z+8/fxfqq
	XCHBWjc/sbJkUxa/F/0LJPHMAFYv2aZUsqm5Qe2PQvDAI9aE2TRFuRjoNWvz/entMQPet4BqHQ2
	vsZS4l2FQPqlvAJi2u7bTiIH2zsMafjUE/rZ8+xnIaPLPUKU+ZpoZ0uSxNU1pEQXL2y9FzvkyMe
	SoTfNYX4NcdFdfd2pVJUrDljqO2ic4T1MT9MaPYcgp+ex2DmWKYL3jLkx254zvNbYlnhItNDgt2
	UXyphWlaM+O4dIFUOfSBMK+ZFL8v5ZULiGv6WGEVar6xW2bFdkfRQgSagCW7mf+tVSL6qdmUkM0
	7XKHT/cwpIGWDXrC7wB/uPjwWgKu/RxX0D0Pkwbpnn4La2PPfNvec5+4jza90p8nRvquuTw3brH
	+zrk/jYMw6mrdzBHvonowOYlVa4qsHXbobOfmsB86tFg0I9FM9RGS0uokiyTDaf4z2YwA+iau7J
	5hwVnAdPEdBvIYbcdrchMCZd2uOoP7XMm5xGJQ==
X-Received: by 2002:a05:622a:5c06:b0:536:60a0:5515 with SMTP id d75a77b69052e-53e3f95510fmr21198101cf.17.1793055592065;
        Mon, 26 Oct 2026 15:59:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5383970ac84sm65824991cf.20.2026.10.26.15.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:59:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLTfS-000000089Kh-2dEv;
	Mon, 26 Oct 2026 19:59:50 -0300
Date: Mon, 26 Oct 2026 19:59:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>, Armin Wolf <W_Armin@gmx.de>,
	David Lechner <dlechner@baylibre.com>,
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
	Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261026225950.GD1685504@ziepe.ca>
References: <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <2026102437-vista-unsoiled-b089@gregkh>
 <at34UOuYv3NtX36R@monoceros>
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
In-Reply-To: <at34UOuYv3NtX36R@monoceros>

On Sun, Oct 25, 2026 at 01:48:04PM +0100, Uwe Kleine-König wrote:

> The more I think about this taint, the more I believe the commit should
> be reverted and replaced by a some stop gaps for driver_override. (Be it
> a taint or better yet
> https://lore.kernel.org/all/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.1790612298.git.u.kleine-koenig@baylibre.com/
> .)

I also think this patch is way too broad and should be reverted until
something better is designed.

To me this is very similar to the filesystem issue with syzkaller
fuzzing the block device and crashing filesystems. They said
filesystems touching untrusted block devices is out of scope.

Same here, kernel drivers touching untrusted HW are out of scope, we
have never supported that.

I think a taint from force binding outside a match entry and using
new_id are probably about as far as this idea should go.

Even this would still regress most common VFIO instructions though, so
some kind of disable for VFIO would be needed. I don't agree with the
assertion 'servers are already always tainted' that doesn't match my
experience at all.

unbind should not taint, we support hotplug, and manually binding an
authentic match'd driver should not taint.

Jason
