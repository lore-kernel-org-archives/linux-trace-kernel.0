Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2D2DF6E9;
	Thu, 19 Feb 2026 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771526395; cv=none; b=Q8Q8lTPzHO7IcrMl1Mp/KK8hsPLbpbdevDa9/hibbI7hR01Fac8iaBRNV3ChKeUH2Ig08Lj7F+ZnzuYNz4ZKJ8p68XEYp23zXLQindkmDvoPnbvR2ZrTpNha8d3e7Wtr7T2vq1VNQiowU3p+xwmw+lPFwT0lhXElG/mFv5ce/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771526395; c=relaxed/simple;
	bh=tPb1cb7NJv6EMuMLd1zkVcmwwK4p2YayN9JnHRRIq3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHZ4H2cmUHqnJpANsCvb7gw/lGBEy7bm0fNo/FuXMoYCzLt1I7BfD4JNr5o4RpRhj9faDpr+4MyXL7y8l6wPQrw8q/aPhUkXYkI4P7B7xAfaJjZVSyUbC7DIlmY1H5WE+m4mVGPWXjq/aU5MuAmhLnuP/pM9jcdGgYffhiAlEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4uNk8zb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4uNk8zb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDDCC4CEF7;
	Thu, 19 Feb 2026 18:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771526395;
	bh=tPb1cb7NJv6EMuMLd1zkVcmwwK4p2YayN9JnHRRIq3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4uNk8zbjpUN9OS/4HErwXvhCEAqCrPqPv+2MExdawqLvZA8+0/bxhqzgogUPPmn1
	 3NjIwx9GOeGl3gtEg10l1On/drUYRQu/ygCGl83o596xjIoK+cIo3fdwHv15AJzgNo
	 nTgASxOShMpvlHYMsdWj524pGMLdjUveULSb8OPlNLbRfsKPflP+q18I9i9KFwZ91+
	 NMfDq//Z/NiaBBZHaQgeP4ezzvATVw8+CRtZlU9Lx+ms2acUoz/lZYfs6VVOEuwVQB
	 UKQp1mpPscuS3hVvifqKcBxjlAYQhp/nc2TBhmVDS/9Z3zB6NCXYoQBLZdigdPficH
	 RUbcQ+rlqllBQ==
From: Kees Cook <kees@kernel.org>
To: Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-trace-kernel@vger.kernel.org,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] pstore: fix ftrace dump, when ECC is enabled
Date: Thu, 19 Feb 2026 10:39:47 -0800
Message-Id: <177152638326.270874.15229340696077365324.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260215185156.317394-1-andrej.skvortzov@gmail.com>
References: <20260215185156.317394-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 15 Feb 2026 21:51:55 +0300, Andrey Skvortsov wrote:
> total_size is sum of record->size and record->ecc_notice_size (ECC: No
> errors detected). When ECC is not used, then there is no problem.
> When ECC is enabled, then ftrace dump is decoded incorrectly after
> restart.
> 
> First this affects starting offset calculation, that breaks
> reading of all ftrace records.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore: fix ftrace dump, when ECC is enabled
      https://git.kernel.org/kees/c/07b7ece8aca0

Take care,

-- 
Kees Cook

