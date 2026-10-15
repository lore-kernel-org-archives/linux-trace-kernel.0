Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBDC4DEC0C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070526; cv=none; b=Oxym17MdP368ePtbFLyu3h34PFMLynwk4Io3yuL859F2sC8r2GEYOu+MvsVvABO1TgBsfhCb9btwGnMoE+es3PpNW75Fyn8z5/WOL1NQMTOYaWOdCEyrpJE0+hEClpPr7KCIP1bMay4ALvdJ6zMI99GQ9VsRs/GUt9TAs7bw4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070526; c=relaxed/simple;
	bh=SMysF/7OMJJxnTfLDS0irbeZgQ8ACkMLBuKtsAuLKVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=SiiaSnpLxrnulQ4S6Z4ZxdjHGRS5w7SR+AOWlqnH26I/DkUq8Iox7pNULwMmGU7o7eQWBBurC2zNx6qugXhIn6Xgob5kuptwwbUABdZtNVM7P/28VSc5a+Tzxcps+RU24GXFDGh3pKyB/ksSolRY5spGLQl2ZeGhVgx/MZiTksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMls2BhG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMls2BhG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87721F000C4;
	Thu, 15 Oct 2026 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792070524;
	bh=s+HzBkBf8qEZmqiziCnNgMlI6ehw3MKXSePN0nW37Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LMls2BhGr1o0GWhbXw8+5YC7YtdiibL4s0SmVNGWcOX6HuSBG3w1i5M9Xx4ja96DA
	 V2hWt1dv5hqipGKStGiu9KoUAmExNO1PSN3ch3KiPyWwCtLca3oNZl/Nu1S6DZlhQA
	 9p5M44/EiQsddbjgkn77hq+S/ZFl/dngCdoWAGIaO3YwmC3BCYjw/SxJ8T2wO4zYlK
	 EQQ1mAS38CICYAhSjH1p9wfifm0cuqth3GYUsO70vZV5OhZIP0VLgU1eRYq7PbUvob
	 NQAvDHJCDiTVAGouxuIsmK81HNKOZqFA8XAJ4LOL7orKEUhiMlce/rozQ0FzaA1Ptl
	 dCS2+dX0ctN8g==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] riscv: kprobes: add KUnit test for LR/SC sequence
 rejection
Date: Thu, 15 Oct 2026 22:22:02 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-171103@kernel.org>
References: 20260828091202.1124-1-yuanxiaofeng@eswincomputing.com
 20261014094415.374-3-yuanxiaofeng@eswincomputing.com
 <sashiko-outbox-171103@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261015132203.D87721F000C4@smtp.kernel.org>

On Wed, 14 Oct 2026 09:54:54 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kprobes: stack-allocated kprobe leak and UAF on unexpected test failure
> --
>
> commit 10b8cab517db949a43dcca583dbcd1f20f6d68e8
> Author: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
>
> riscv: kprobes: add KUnit test for LR/SC sequence rejection
>
> This commit extends the kprobes KUnit test to verify that register_kprobe()
> correctly handles an LR/SC sequence. It asserts that probes are accepted
> around the sequence but rejected if placed directly on the LR, SC, or any
> instruction inside the sequence.
>
> > diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.c b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
> > index 027424a3ff7b1..2727537569739 100644
> > --- a/arch/riscv/kernel/tests/kprobes/test-kprobes.c
> > +++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
>
> [ ... ]
>
> > +static void test_kprobe_lrsc(struct kunit *test)
> > +{
> > +	/*
> > +	 * test_kprobes_lrsc_offsets[] points, in order, at an instruction
> > +	 * right before an LR/SC sequence, the LR itself, an instruction
> > +	 * inside the sequence, the SC, and an instruction right after it.
> > +	 */
> > +	bool reject[] = { false, true, true, true, false };
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(reject); i++) {
> > +		struct kprobe kp = {};
> > +
> > +		kp.pre_handler = kprobe_dummy_handler;
> > +		kp.addr = (kprobe_opcode_t *)test_kprobes_lrsc_offsets[i];
> > +
> > +		if (reject[i]) {
> > +			KUNIT_EXPECT_LT(test, register_kprobe(&kp), 0);
> > +		} else {
> > +			KUNIT_EXPECT_EQ(test, register_kprobe(&kp), 0);
> > +			unregister_kprobe(&kp);
> > +		}
>
> [Severity: High]
> Does this leave the stack-allocated kprobe registered if register_kprobe() 
> unexpectedly succeeds? 

Good catch!

Xiaofeng, can you fix it?

Thanks,

>
> In the rejection path where reject[i] is true, KUNIT_EXPECT_LT() will log 
> a test failure if register_kprobe(&kp) returns 0, but execution will
> continue. Because unregister_kprobe(&kp) is only called in the else block, 
> the kprobe remains in the global kprobe list.
>
> Since struct kprobe kp is allocated on the stack within the loop, advancing
> to the next iteration zeroes out the reused stack memory. When the function 
> eventually returns, the stack frame is popped. This would leave a dangling
> pointer in the kprobes subsystem, causing a use-after-free or kernel panic 
> on subsequent kprobe operations or interrupts.
>
> Should there be a check to unregister the kprobe if the registration 
> unexpectedly succeeds in the reject path?
>
> > +	}
> > +}
>
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261014094415.374-1-yuanxiaofeng@eswincomputing.com?part=2

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
