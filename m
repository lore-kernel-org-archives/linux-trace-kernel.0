Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536935;
	b=TAolmy1UroNyjGiNRfIdh6S+T/JxQAPNlyIYbY7xQEeF/OXFaQGn4rSclyB3figsA0d7
	 uMkWIZKqpKdY0myEJJ26p4kswYcdPz0a4tLh0g9uDZ0q2Z74MlmicSaN3wiGmJCCXtVv1
	 MhWNsMnKO/gyW6HsMj7OU3D9IsNIrAuLcdZk9uKTUGQKod7ZjAuWNEWzsDJyni0z2NeFE
	 HQw7zwmFJzYP8YensaQ1Sdhfeu1QvaCRrFfqN9wPEuetCpxP/rcou70HwQlpJNDHV2LLq
	 LRF/QZTZjAPvHLSYrQF4J1d2ybUpon0BXl9ZUxyoRHnKxBhczbIY0wEmWLXg4tDsLEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536935;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AHgBCXI1TGb8hEAyobjrNops8F8v2gDESK7c0ZGONpc=;
	b=1zPTeYrWjCJqltCbDsQtvBZ4/xpf2cXh/M7nloKEFlRcZ25Z/LJKm3gGEp8BPm45tc3/
	 OQZuqGu+rN8O22c2larPrROAK650reh1kZTSIAkbVoqwfLoMepdufmN/y6l70emHdRwi8
	 sSg4wEAcOREjZh0aFNYfBbWA3tafHxLEu9mMi7jB2QR0nNzU4OpWfr/0FFks7BiwI6n6A
	 0Se6/QKHaJbQXgyqA94G7/SXi1491R2/U0+fYwZNZQMFqeEv2rCMjux/CcIY452WECYJl
	 fOJKwNz8pA2I0CarKGo/bpSo6aIQXXzwjiA61t3A0GJEj2MeUThvPMjtmc+kBa559ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ha+3WiIm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E5606A321;
	Fri, 13 Nov 2026 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ha+3WiIm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9A31F000C4;
	Fri, 13 Nov 2026 02:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794536935;
	bh=AHgBCXI1TGb8hEAyobjrNops8F8v2gDESK7c0ZGONpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ha+3WiImmHrHVVg5jbbSbNES/G7LB9J+2ADswAepkKUmqMM0WtxT+duKyNw2yUPps
	 RTR8EK5QZXDMZ/WGeTIcvJM2WJjQabuS9Zv9m7MK9v3ksDmclmkctwoSe+iLhkaDpr
	 9r6t/8ikEPXuNMqL8LKxZMtSeSZQt5VUs1mTMOdOVx20Qh5FFrVAzSNOb9qYgWzUps
	 CzCReYrlJd2Yho1bbj++DRpS9AREeXqxySX66OXp40Hnufqc7PG670Z/RgdVShs43M
	 LleXar2CB8PFfN7AM36gVUFioJYOvS+D/Exqc65ZYa9pZDWl8mLjJ6fJAyh9fqOlj2
	 7P/5iH8UyeO0A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] bootconfig: Preserve values and key paths during parsing and output
Date: Fri, 13 Nov 2026 11:28:52 +0900
Message-ID: <undine-1794536932799279555-f9c303a1aba9ec59@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <cover.1794337724.git.edumucelli@gmail.com>
References: <cover.1794333957.git.edumucelli@gmail.com> <cover.1794337724.git.edumucelli@gmail.com>
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

On Tue, 10 Nov 2026 20:08:44 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> Hi Masami,
> 
> Thanks again for reviewing the earlier fixes. This v2 addresses the
> issue Sashiko reported in the first patch.
> 
> The parent array in v1 assumed that the parser always enforced
> XBC_DEPTH_MAX. I reproduced the reported overflow with AddressSanitizer
> using a 20-component chain where each parent also has a value. The
> existing verifier skips the subkeys in that case, so the parser accepts
> a deeper tree than the formatter's array can hold.
> 
> Patch 1 now checks the key children to determine whether a node opened
> braces, using the same conditions as the forward walk. It no longer
> keeps a depth-indexed array. The existing verifier gap is a separate
> issue; this revision removes the formatter's dependency on that check.
> 
> Changes in v2:
> - Patch 1: derive brace ownership from the key children.
> - Patches 2 and 3: unchanged.
> 
> I tested this on my Ubuntu machine. All 137 focused checks pass for the
> combined series, and the full bootconfig suite passes after each patch
> (86 passed, zero failed for the complete series). I also checked the
> revised first patch and the combined series with AddressSanitizer and
> UBSan using value-bearing chains up to 95 components.
> 
> Review: https://lore.kernel.org/all/sashiko-outbox-207566@kernel.org/
> V1: https://lore.kernel.org/all/cover.1794333957.git.edumucelli@gmail.com/

These looks good to me too.

BTW, what checker did you use?

Thanks,

> 
> Feedback is welcome.
> 
> Thanks,
> Eduardo
> 
> Eduardo Mucelli Rezende Oliveira (3):
>   tools/bootconfig: Close only opened braces in compact output
>   bootconfig: Trim unquoted values at end of file
>   tools/bootconfig: Preserve values containing both types of quotes
> 
>  lib/bootconfig.c                              |  5 ++-
>  tools/bootconfig/main.c                       | 43 +++++++++++++------
>  .../samples/exp-good-mixed-kv1.bconf          |  5 +++
>  tools/bootconfig/samples/good-mixed-kv1.bconf |  5 +++
>  tools/bootconfig/test-bootconfig.sh           | 29 +++++++++++++
>  5 files changed, 72 insertions(+), 15 deletions(-)
> 
> 
> base-commit: 677f83795fdfc25ddc51b665a9111f5ff199f7ca
> -- 
> 2.53.0
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
