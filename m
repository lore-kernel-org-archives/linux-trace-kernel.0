Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181027;
	b=lnXLSI9YZ3VvysKYJlnc/86n0bmjwHV1DFWpC+L8OXueM0cg8LI1YOb0g1NK73sQ5i0a
	 lRoRhzYVdj7EN2bpFbzEaDdeFiqeQ21By+ZmHglllHyiJh0FTcxARnS0/7nToJGU57G0v
	 24S3gJ5RXrCHiyWi2LSOlPWEIow1D9+Skd3n7sEl5CCcz4+ukxAx8YNsOCXr0Ou4aWk30
	 b5w9OuTkt4667Mq8asy5p0MVJ4/DraIp7+e9ti5UuVavwMPun3QH7r0Igfe51udMj7P5D
	 2SwfQWWGqzW+UoOPbs8XVYMJKtjshcLGrxZE1effm3bv9in/KSJJJLEwcgRQvsAYX6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181027;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SVkURMmI1n5DQqFTl9izdNxaJIE4oZ+bGYQ440Te6lg=;
	b=QSAFsWBnv9iGKGUqCSPqmgg1EoVmgUIRw6ri0TnrGsEV1/QjpJVhthXcYLVHugWKuhIl
	 w5+w0TdyipFrtg3ZQinlK5h1WGZKf6CrFHKkpuowY7x6aHAzBk0gVuTZocGr9f6NMbIhg
	 csZnSZa8sqVKUvhtcofjQ7OL83Jk12fjanf4X95S+qVNr6FbtS6NoW8A3IXJ++QvAm4Cs
	 r9iGPu5ckU2hSLFR7YP9RQ7HCyfKuK0eCdMsn1HTl7ydCCtRwSwwu0By4LwDbgbUOPM/1
	 G0g5xHTtXFkWxO3dVEXH+TjPY0kmEZbU56rDv73dyq0cwTB3AtjerJgsii6PfQywBSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0srTtJZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9A606A31C;
	Sun,  8 Nov 2026 23:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0srTtJZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7167B1F0089F;
	Sun,  8 Nov 2026 23:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794181027;
	bh=SVkURMmI1n5DQqFTl9izdNxaJIE4oZ+bGYQ440Te6lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0srTtJZxVfK69JTchpUOOWHTnslQ5pFPyEjATTargwN90/F4z/MCfb7N5E35P432
	 lZBTAY1GdBFF6e7ilBSlAVFPMPszldaO4tGOkKkrV+5qGnQr6Mx+SJsVaEUOJDmxsG
	 PydBxXd50P0zASoagGTFruRs7sP+/LOyIvSRE0kZ+JmgNWzyvEY7BumUvu15lSHMbC
	 JhcIT8FDT4EE6eIRsAT2MgJYP9a2B0WbkUQ+rXcITcgNL+AbT58p+gvdTi7+3IxMhg
	 0k+3TFGuLdMp8bf+yoACJ6g4F51U/gveWacCQXiUhhLyKQqxaG1quOY5xAaS+ElHks
	 oFOnUKLE36eNQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu, Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH v2 0/3] kprobes: Fix optprobe state after forced unoptimization
Date: Mon, 09 Nov 2026 08:37:03 +0900
Message-ID: <undine-1794181023657892401-a2bac730c53958e2@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261105-kprobes-optprobe-state-v2-0-7a2f5290baa0@columbia.edu>
References: <20261105-kprobes-optprobe-state-v2-0-7a2f5290baa0@columbia.edu>
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

On Thu, 05 Nov 2026 15:32:11 -0500, Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org> wrote:
> Since commit 06e0d3b89da1 ("kprobes: Make optprobe optimizer
> multi-generational and asynchronous") a forced unoptimization can leave
> a probe's int3 in the wrong state.  A disabled probe can be freed with
> its int3 still in the text, an unhashed probe gets disarmed twice and a
> reused probe never gets armed.
> 
> Patch 2 relies on patch 1 since it assumes every disabled probe on a
> cooling list is already disarmed.

Thanks for updating! This version looks good to me.
Let me pick it.

> 
> Changes in v2:
> - Patch 1: disarm a disabled probe before choosing the freeing or cooling
>   list (Masami)
> - Patch 3: keep a reused cooling probe disabled so register_aggr_kprobe()
>   arms it only for an enabled new probe (Masami, Sashiko)
> - Patch 3: skip the forced unoptimization in add_new_kprobe() for a
>   cooling probe, which would otherwise unhash it when the new probe has a
>   post_handler
> - Link to v1: https://lore.kernel.org/all/20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu/
> 
> ---
> Mani Tofigh (3):
>       kprobes: Disarm disabled optprobe on forced unoptimization
>       kprobes: Do not disarm unhashed optprobe on dispatch
>       kprobes: Arm reused optprobe on cooling list
> 
>  kernel/kprobes.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> ---
> base-commit: d4d028a7ae6401ce70825a3eb663f0a2dfc49db6
> change-id: 20261103-kprobes-optprobe-state-90dbf55b246c
> 
> Best regards,
> --  
> Mani Tofigh <mt4022@columbia.edu>
> 
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
