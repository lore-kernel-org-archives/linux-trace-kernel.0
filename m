Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536882;
	b=3a2qLPKSItWuCQDtH2x9JsJMqWPGw1khnYrA21NSV+Ft4/jfJtKJ3HxM1/2/B1I9j7rV
	 +vs0CehJ3vuEBkd8Y7uQxy6emYvEm336gEcVv1QyLe314sY8G/9qZPL88ScAY/s1Gc5ql
	 zjDPCDpx49sGKqXDpn5aLQe80PPvU+YGmBXBDU81mvCTnZCdvu5mOTJIzhcP8lmOBEw2b
	 S/9vh44auWJw9RBtJQoNkxIaHFI5QeHrbmtS6OqOIkUhzMLirda5q5PWe0/FDoLv0kw+8
	 ap1YwprQW48Eh4qQ6NeNS+8g5PBw+Re8HTLWkdz+TeJGkY+aBb5GrrtDVr5j0N+fX9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536882;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2qW4WKjboBuDMx75ZmNMnV4KAw3QtqmLiMlJ1bN7aOg=;
	b=DWMGp8HqQYiQONQ2hIVHHem9nVGfneGH0Nk3pEeC3G2ZvN2w+TsifRPgRlL/84HHEcT4
	 rknpRnhgMvS1gHl3gUPJHGpxXoURAR/+nK03ylZsjBLckepVOLU8Ltsd1sEQNk3PMWdMA
	 7blH/HDUGe+qSy/jAT3juWdxLSg15S0fsYp9zBPd2EvpMXunafo/nK8bEkEoS+qwMY5Pl
	 W/nvUJ8OXh58Ez+FTCZLRm5+zT7zVYq+S2JaVkUMtkJrRsV7bhNTbB8Baxe6+neZnilZj
	 azTnvPkFzeMaPz0uuXcIYJ0+bM7Gummuqge1F1sQR5aR7GwueGAemUkS02gR3uPFbjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEQPWvtU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E10606A31C;
	Fri, 13 Nov 2026 02:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEQPWvtU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747181F000C4;
	Fri, 13 Nov 2026 02:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794536882;
	bh=2qW4WKjboBuDMx75ZmNMnV4KAw3QtqmLiMlJ1bN7aOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bEQPWvtUWlcGhjK0xOe5IAC7JOPOg/SxeO9ML5DvmcqQTgrjVVFjhXE/jfsZaT8M3
	 W66r7L7O4eCpKI4+eoKwInHhgmH8BqfEjtFg7RUa2aVp3eA4zQmnO0IMGTU2kI8HYD
	 3Ug2U8jaCWGNnAk0o3kU/rx6oVBw+3Xh0wEe77XeO/w2UQ582UBr153peJ66XeeZKb
	 5R6oXxhQR0r8CJleqI2IT3LL1Re7l1ZJj1lcCzcNZIEuBt4vkShviSZtjJ1LbKDJ/+
	 kTSh5e9wH81sI9fDNgRmHobEtjUEQIGP7sugDUNMbgOcp1RhHuLsVE80hcLEabcvzE
	 AapxdaEqeIEfA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] tools/bootconfig: Fix tracing script filters and histogram dependencies
Date: Fri, 13 Nov 2026 11:27:59 +0900
Message-ID: <undine-1794536879791872271-52b7971cdf78b6ad@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <cover.1793471731.git.edumucelli@gmail.com>
References: <cover.1793471731.git.edumucelli@gmail.com>
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
Content-Transfer-Encoding: 8bit

On Sat, 31 Oct 2026 19:35:29 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> Hi Masami,
> 
> Thanks for the reviews and for picking up the previous fixes. Here are
> five more script fixes, based on bootconfig/core as you suggested.
> 
> They address:
> - The documented ftrace.notraces setting being ignored by bconf2ftrace.sh.
> - Single quotes in event actions producing invalid exported bootconfig.
> - Literal filter text being mistaken for histogram variable syntax.
> - Valid histogram dependency chains exceeding the exporter's retry limit.
> - Helper key lookups matching unrelated bootconfig keys.
> 
> The action-quoting patch follows up on the trigger-filter fix you picked
> up. It uses the same warning approach for unrepresentable values that
> you suggested for event filters. The histogram scan uses POSIX sed.
> 
> I tested the conversion and export fixes in temporary tracefs instances
> on my Ubuntu machine, running kernel 7.0.0-38-generic, with recording
> disabled. The tests cover each relevant step and the combined series.
> The helper fix has focused checks, and all 81 combined fixture checks
> also pass with POSIX sed.
> 
> Feedback is welcome.

OK, these looks good to me.

Thanks,

> 
> Thanks,
> Eduardo
> 
> Eduardo Mucelli Rezende Oliveira (5):
>   tools/bootconfig: Read the documented ftrace.notraces key
>   tools/bootconfig: Preserve quotes in exported event actions
>   tools/bootconfig: Ignore filter strings when resolving histogram
>     variables
>   tools/bootconfig: Resolve histogram dependencies until no progress is
>     made
>   tools/bootconfig: Match literal keys in tracing script helpers
> 
>  tools/bootconfig/scripts/bconf2ftrace.sh |  2 +-
>  tools/bootconfig/scripts/ftrace2bconf.sh | 27 ++++++++++++++++++------
>  tools/bootconfig/scripts/xbc.sh          | 13 ++++++++----
>  3 files changed, 31 insertions(+), 11 deletions(-)
> 
> 
> base-commit: a52ceed51e9bf8f1ca9c2c868b14bf6861986c65
> -- 
> 2.53.0
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
