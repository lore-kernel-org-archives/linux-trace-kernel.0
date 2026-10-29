Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236112;
	b=ZLF4Niu3vM7hLbFcCSwgZyLu5BlPqggritViKqNQUrV+CZEcIdiVmvagpiZOq9rle+LY
	 FWIJ4HHvrEN4xk9KRRIGoalac1+vthW3z5z3BgcHI1OwalVVxbcmlwCQYose/fxv7MPUc
	 AVGYG1CkYm9MiUluYsEQ56vryRuBWoA61vg3dFKr7j218LnNOyq45rN+IYkpOHpCqrIQE
	 kVQdBWzyGv9jvqGGBsdoQqphRX0yPr2Ci/MwGHIJ0jPB00UZNUCwMjuvDFvKNUQO/rRXp
	 s5WDk0K7P7EYupVMqNUvNUmNoKpYRgOKfjg9/w754ukmIFq3vfHyGc/YA5T9VvD4Vww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236112;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hUylxsrziYK06GtP7xJhB2B0ARi8my6UHywPSMuSNqA=;
	b=LSDMqZlMeGQR21MAAqeXnyn7E55DLWrIzN9/9TjrpOXZ7DlY50LbnvqCQCZW5/RDdvmf
	 eh92DdLfZ8RB3q0U/AC46tGH0YaIMY9ZaQI4sWw+FIy1qZGMg10JpPmvSCVmWSZDbMktq
	 VgoR9sxiRuvBCswCtriw7uUZuktrDQNR8kDOmGEzQTUogI7xzpIf0ueiyRh2sdlQcOVfR
	 H8yV/di5aRYiFxc/I0IJlgE/5krRSKys35QMw4TVMKTKOcM2xtLcXXuJDhoMNAoNWJGjZ
	 TrGd4/pKRUqgF/4CeiwFoPvPSPvE+6FkmCcTzrzU0WBTZpH/iP0E6xhjCUEqIoVr6qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jj6TQPZv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716AD606A31A;
	Thu, 29 Oct 2026 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jj6TQPZv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B731F01825;
	Thu, 29 Oct 2026 01:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793236111;
	bh=hUylxsrziYK06GtP7xJhB2B0ARi8my6UHywPSMuSNqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jj6TQPZveZnZpvbuyMaUm+pfqoyXtZwK7M2GSXnHtNgQJZpSoOdeiJRztJpviI6NB
	 nvdEzMHCNPvddPkk8GBhVYT2R2ALtvUuHqWEf7TLJpDfQ3lx5bLA6CQHgKV+CV/YBG
	 KPrwPWYUdwh8tG+HG9ax7YvwT98daI4UqIk/IC1rZ5tEmrnSydVadEZdWVxp/r1ZT3
	 A9daDgXzRdKc86GnysIAoAy4XIp3xPSrIGHIGxizMYkW1NG4cNuk1L5kXD9SOtCJog
	 AVYV0g2vZUWzfH04DTrTItSkibJbjQNtBGDkTU2M62tuixXpcbP6f/rmGzWwAp2Qt+
	 nOt2+Ob7kYCBQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: thnkslprpt@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/bootconfig: pass init arguments in documented order
Date: Thu, 29 Oct 2026 10:08:29 +0900
Message-ID: <undine-1793236109048848648-013753fe98f18601@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261027073719.4010659-2-thnkslprpt@gmail.com>
References: <20261027073719.4010659-2-thnkslprpt@gmail.com>
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

On Tue, 27 Oct 2026 09:37:20 +0200, Avi Weiss <thnkslprpt@gmail.com> wrote:

Hi Avi,

Thanks for fixing this! This looks good to me. Let me pick it.

> start_kernel() appends command-line init arguments before
> bootconfig init arguments, while setup_command_line()
> places them in the opposite order. As a result, the
> arguments passed to init do not match the saved command
> line, reversing the intended precedence of options.
>
> Parse extra_init_args before after_dashes so command-line
> init arguments are passed last.
>
> Fixes: 1319916209ce ("bootconfig: init: Allow admin to use bootconfig for init command line")

BTW, the Fixes: tag should point to commit b66fbbe8d482 ("init/bootconfig:
Reorder init parameter from bootconfig and cmdline").

In commit 1319916209ce, both setup_command_line() and start_kernel() placed
extra_init_args after command-line args. It was commit b66fbbe8d482 that 
reordered setup_command_line() so that command-line init arguments come 
last (to allow cmdline to override bootconfig), but missed reordering
start_kernel().

Thus I will change the Fixes tag as below.

Fixes: b66fbbe8d482 ("init/bootconfig: Reorder init parameter from bootconfig and cmdline")

> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  init/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

