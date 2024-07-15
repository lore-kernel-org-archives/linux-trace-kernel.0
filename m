Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834D185E76;
	Mon, 15 Jul 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034862; cv=none; b=l0wWS5dh6VilNBs+YhhyftpIrKVqxiyFQFdwTcvlBKorqen1qRceSVFDpQbf1jH3ayAY19BpESaAOS6MLYxPnx53x0KM5Z7MY++5iDjfHyreImv5/DHPfpgk3QTlo+anXSjaQQ7KjSeSplr+PRPQNh2FxQ8qL1QVpv+NUpNqkq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034862; c=relaxed/simple;
	bh=1UZlCL7rxbfgdLZnAyH9S3LQgPx4FjeGy7ofPiuTxRk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aD6lSk2wJkZW28guO5BQ2ZD7iSjsNx2aMN0EunLKpr6t+TMiOUDKGZ/b8kmCydi4ntNtAMLTIfJKsXT/1tJujFd7T4ljNjsQZ4zYV8TL8WBxO6SdlV3DstBQUX/XX9DdPswm3F86vR6veUubk+LhJXBPBvZyBGJpnsJQZCZlhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm9VEsua; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm9VEsua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08427C4AF0A;
	Mon, 15 Jul 2024 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721034862;
	bh=1UZlCL7rxbfgdLZnAyH9S3LQgPx4FjeGy7ofPiuTxRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qm9VEsua16jJcf8oEUAGYce8R1pYpEBf7jNeSjw6AxdTcSBSGsuNd7Ovw2Kes7T6q
	 hKTEADARgCBosEpdCsTLGg3SM4VawK+AFSJfntZFCtCxgUlvQCANrL+2K6IRa6NIEG
	 x6y1D8EzjZU0dSAWjdp7Pa8HOswRME3/SmoIUlYL86HxuLv8Jorr71yrC9MhB5RaeM
	 ZVH0mNgekCQcTX/ON3XeoRXE/afHZ1S+yfRzXJpiUbtVbTORiV7yg6asoexXx1mRL2
	 ygHmCCN8r6ysS3gJjZw6GGUiBzcmx9A1SnPrQWHvH7CY1Ufj9oaEyHv9164fdoSN1i
	 j2/J9FbDJaSzw==
Date: Mon, 15 Jul 2024 18:14:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
 mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add uprobes entry
Message-Id: <20240715181417.6421de1e1a18a39685533115@kernel.org>
In-Reply-To: <172074397710.247544.17045299807723238107.stgit@devnote2>
References: <172074397710.247544.17045299807723238107.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Peter, Oleg,

If this is OK for you, please give your Ack.

Thank you,

On Fri, 12 Jul 2024 09:26:17 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add uprobes entry to MAINTAINERS to clarify the maintainers.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  MAINTAINERS |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da5352dbd4f3..ae731fa2328c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23105,6 +23105,19 @@ F:	drivers/mtd/ubi/
>  F:	include/linux/mtd/ubi.h
>  F:	include/uapi/mtd/ubi-user.h
>  
> +UPROBES
> +M:	Masami Hiramatsu <mhiramat@kernel.org>
> +M:	Oleg Nesterov <oleg@redhat.com>
> +M:	Peter Zijlstra <peterz@infradead.org>
> +L:	linux-kernel@vger.kernel.org
> +L:	linux-trace-kernel@vger.kernel.org
> +S:	Maintained
> +F:	arch/*/include/asm/uprobes.h
> +F:	arch/*/kernel/probes/uprobes.c
> +F:	arch/*/kernel/uprobes.c
> +F:	include/linux/uprobes.h
> +F:	kernel/events/uprobes.c
> +
>  USB "USBNET" DRIVER FRAMEWORK
>  M:	Oliver Neukum <oneukum@suse.com>
>  L:	netdev@vger.kernel.org
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
