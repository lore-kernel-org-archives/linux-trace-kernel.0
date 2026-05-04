Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E430F52A;
	Mon,  4 May 2026 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880921; cv=none; b=LnuX8srFMXM6gLF+qr2w3opEwjzyS961o1MT+ngyzm3XtUaM4Y0C4PYhxHSdB6yHMDJmOlzQOqAIlv8GB+ZPVrIUzxCtT4SdvXs18Cl099LKhWlLO7EqzI6Yp2eeuh+XZ7pDLMQw5PQ/5RLpsibM4PJj31bROvnQzytKO0CaJUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880921; c=relaxed/simple;
	bh=onaqy8OxZNXxPjsB9OYQPoOSWxq6VNugfkRBG8B4SDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PYUMNCNHBbKLx5ZiRjrWEDPIFiQmY9gh5VHvwm7SgNwT1kZRTV3u+pY1sFAukbm4PdMc+YJZGcUvQjnovZ8O9gwhWjzCzY6n9qhtBKoANUmI+IWKxOk6xyFyBYIC35mUZc2DeKKnihVxdok4o20YiuMZ6sQkabkzKAgIlSHa6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WfuszEsz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ykqd50B7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WfuszEsz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ykqd50B7"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777880918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4sK++8oqvdIrLGDdYeVamQmI47JkwNQUlocUJbuiJk=;
	b=WfuszEszvxV/BXab6Z0dlUh/asERSphNIKldXjhl10qctQ6eQLUKtCDncyd5Qp2SviE9Fw
	WakWiMTdWUPgPK+NcZHH/5EHiEmiASKuMG2ZcU4uuwade5megqcndLxg9HJC0o7gEjgPwp
	Sy6U04GGlwh3V/gkFPbkhZR0hPEVE+FN0Dw5lJ0Zgk9/Ncoog6IiABKEnoKuVbL68uylQ2
	juZ3Tb2miW8N4vNpQWRR5huAveySdPUdPcWpgP2rEaLNoIaFmj0k6eCygMYtzaFIm39rX/
	sLLKF9pl9NOLk3yM9+4Ymk7006n1Uz93DHxezi9wsw3W00LK0GPgLB2RA4EADA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777880918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4sK++8oqvdIrLGDdYeVamQmI47JkwNQUlocUJbuiJk=;
	b=ykqd50B7EZXcdsUWmGOGNLdGaKU5FlnOhk3r//OZxXmyfECpF0CLi7Ej3q27izeazYRHGb
	g3P1vU1qkQPP6/DA==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [RFC PATCH 07/12] verification/rvgen: Add golden and spec
 folders for tests
In-Reply-To: <20260427151134.192971-8-gmonaco@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
 <20260427151134.192971-8-gmonaco@redhat.com>
Date: Mon, 04 May 2026 09:48:36 +0200
Message-ID: <878q9z1up7.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> diff --git a/tools/verification/rvgen/tests/specs/test_da2.dot b/tools/verification/rvgen/tests/specs/test_da2.dot
> new file mode 100644
> index 000000000000..bfee6e535cf7
> --- /dev/null
> +++ b/tools/verification/rvgen/tests/specs/test_da2.dot
> @@ -0,0 +1,18 @@
> +digraph state_automaton {
> +	{node [shape = circle] "state_b"};
> +	{node [shape = circle] "state_c"};
> +	{node [shape = plaintext, style=invis, label=""] "__init_state_a"};
> +	{node [shape = doublecircle] "state_a"};
> +	{node [shape = circle] "state_a"};
> +	"__init_state_a" -> "state_a";
> +	"state_a" [label = "state_a"];
> +	"state_a" -> "state_b" [ label = "event_1" ];
> +	"state_a" -> "state_c" [ label = "event_2" ];
> +	"state_b" [label = "state_b"];
> +	"state_b" -> "state_a" [ label = "event_2" ];
> +	"state_b" -> "state_c" [ label = "event_3" ];
> +	{ rank = min ;
> +		"__init_state_a";
> +		"state_a";
> +	}
> +}

I am working on converting rvgen to use Lark, a parsing library:
https://github.com/lark-parser/lark

This test case breaks the current version of the new script, because
state_c has no label while the script expects one - the script read the
state's name from the label.

We should define if the label or the node's name is our state's
name. For example, if we have:

    "state_c" [label = "state_d"];

Will the state's name be state_c or state_d? Or should that be a parsing error?

I propose using the label if one is provided, otherwise using the node's
name. So

    "state_c" [label = "state_d"];

means the state's name is "state_d". But without that statement, the
state's name is "state_c".

What do you think?

(just FYI, my work-in-progress: https://github.com/covanam/linux/commits/rv-lark/)

Nam
