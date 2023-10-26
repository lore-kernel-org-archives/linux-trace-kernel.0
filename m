Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90F17D5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MeOUuEUr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZmEwaB35"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DAC10E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:46:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id D99E75C01EC;
	Thu, 26 Oct 2023 04:46:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 26 Oct 2023 04:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1698310001; x=1698396401; bh=X/
	PijnraiQwPR6kcu71L8dm0rdDPgeFE0FVctzkVwuo=; b=MeOUuEUre5ocrDFwTt
	oFmEu46HXztQeZrO31iEnLnock/t4cW/h7+nm5QwpqLO4R51tmboabQcHz8yXjiM
	+RUZHThfx3LN8UQUvsM/Z4e7i3Z/CVof5HI92JHnyruiux3CJdqGX+ZjB31WUpgb
	HvuUNTH1MwMdsqVrq0l7gwVey19/+n/nq4VZTptlZByOHzeC0c5sEXAJ2hBwJSE6
	/xAhJsNTeOSZDSCh7WuUcw6CTqN8KR6pqWU+XdTda02t2spTxi9xDf0MSBRnLfyV
	rIVjMfbRkECXUaZZcTa5Hvb1Tez4oP15hqFIcxb3CCx50Lr1QJe1iW5E84MuDnjc
	/Bag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698310001; x=1698396401; bh=X/PijnraiQwPR
	6kcu71L8dm0rdDPgeFE0FVctzkVwuo=; b=ZmEwaB35RLnW5F3WltP/6ggXeh7wI
	NxvZNzPVIU2o51J/sHR0r8X0aaqp5fC+IFnErdcdPvVxBn3QjT39ze52SilykdMN
	Dwh4DqlPElxlVuPcRqA7IYrFNIPFmimkv19JXpvZiN7FWb+IJpB0zT0+fXt1U0MV
	WAidgTmS9MSJDa252kGJV1uKwBNdLMKo16hJ9GazbWyltggRXuDj7ftYn+P83fTY
	W8oXl0kh9quZVLZdasxlyCMSUeqjg0wiwkQIW7KnStfRXtHAhygZVfJPONnnLxVJ
	Spm3NqFLRsjPtJ5u3Bu31HcyhjoMz+4c2atljdZb+c4HSU9EcLrDUROzQ==
X-ME-Sender: <xms:cCc6ZasY7ZbhFgLLlt5t9lw3GZ8H_xtf5MMC1fw55WANOHRbaDeplw>
    <xme:cCc6Zfc-t5btFGXqSLN05KHPktb4koHQGWipJAYDYjRVleYOpetFO--N7yjzlG8um
    NmLnZZFNk9RCfLgrfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cCc6ZVwRrAN_j6zZGEGJejLmzZ7qde9IQCNuuSCaPPIZUfAqKLbuQg>
    <xmx:cCc6ZVN4jzWNO9m4pta9SDIR_M5yR7rzxwynQOEML0sqiz1RxDY_LA>
    <xmx:cCc6Za-R-NaZ7fm3J2m4ZWG5hMlso9u5C2frUYOGvqXivr6_kvyAaQ>
    <xmx:cSc6ZdZTD3unRMttoYqWU2emGbRi2wmTcteJSytsjkh9Qn5cBWbyMg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B8B93B60089; Thu, 26 Oct 2023 04:46:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e3aba7d-89ac-4b62-840e-992527115a70@app.fastmail.com>
In-Reply-To: <20231026073932.702197-1-wuqiang.matt@bytedance.com>
References: <20231026073932.702197-1-wuqiang.matt@bytedance.com>
Date: Thu, 26 Oct 2023 10:46:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 "Jonas Bonn" <jonas@southpole.se>,
 "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
 "Stafford Horne" <shorne@gmail.com>, "Ingo Molnar" <mingo@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andi Shyti" <andi.shyti@linux.intel.com>,
 "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>
Cc: linux-trace-kernel@vger.kernel.org,
 "Masami Hiramatsu" <mhiramat@kernel.org>, mattwu@163.com
Subject: Re: [PATCH 3/3] locking/atomic: openrisc: use generic_cmpxchg[64]_local for
 arch_cmpxchg[64]_local
Content-Type: text/plain

On Thu, Oct 26, 2023, at 09:39, wuqiang.matt wrote:
> arch_cmpxchg[64]_local() are not defined for openrisc. So implement
> them with generci_cmpxchg[64]_local, advised by Masami Hiramatsu.
>
> Closes: 
> https://lore.kernel.org/linux-trace-kernel/169824660459.24340.14614817132696360531.stgit@devnote2
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com
>
> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>

I think on architectures that have actual atomics, you
generally want to define this to be the same as arch_cmpxchg()
rather than the generic version.

It depends on the relative cost of doing one atomic compared
to an irq-disable/enable pair, but everyone else went with
the former if they could. The exceptions are armv4/armv5,
sparc32 and parisc, which don't have a generic cmpxchg()
or similar operation.

You could do the thing that sparc64 and xtensa do, which
use the native cmpxchg for supported word sizes but the
generic version for 1- and 2-byte swaps, but that has its
own set of problems if you end up doing operations on both
the entire word and a sub-unit of the same thing.

    Arnd
