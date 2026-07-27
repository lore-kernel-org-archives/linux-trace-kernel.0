Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A1F37FF7A;
	Mon, 27 Jul 2026 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785189001; cv=none; b=CRfiR3CwAW9uNLF7K1+fiUUJWG4Bop1QASblSwj8odnm08S1mNTjAJaADOBtTNMaUZdvxhtFzQG0rH9+0MukhZQdSmbIHOlhpS91y5ssnDRY2DBt7CtRPSxjy43vkjtyOXGUy8JiL1gmXf94Wvm4TRiq+gGQHOfakuOeFk2p0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785189001; c=relaxed/simple;
	bh=ZdnYkiMELaWqD42Ovbdv3F3kuvZwORX5M1d0YI894i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euFsEH9qlOs/4KPVC0zh3blBrpbkePf5vLptadh7OjPFGfZrbacsJzvEZ7RKArjnVX/HaMRx/Kp2wP9Uaj/Ai+wl7whk1oZtFM9Av1YskXJ1xt7t0Nw3wAUntVO/ucQgNoNI9Mb0lJD5F1thLR5njYOtGeOE0JZGQtzlxS4W6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVWTMr2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVWTMr2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7541F000E9;
	Mon, 27 Jul 2026 21:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785189000;
	bh=rMfeYsP5GdnuDCfgJKEm3wwcc5Ecr2dv1YHRl9juiCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YVWTMr2cX4ewrBWHXUcAbrlt/cYMv2t1rAY6OmzwAk0jxEusNqzHhIvI+IFi8gusK
	 jeVo2x71CzuTqqbU9a+WJJEvzb73ShnQO3gqhTrXt7a2TPzCUTVkNh3hhVBylazW4/
	 4CeRyCI/IFRdnNyAJZiu6XWl0fPPuPV/CAOpVXlO5mgkBjqTvlCxPdL58ayHHdjWJ5
	 RjdQn+7QE6cmJ2wIBqxj7yx5OPwo/Ife3L3H08yQxcj+ptQNRXXCFsaXSPJmOUv/8M
	 z+lqEfGJ6x5P9pMufpzSSTCyZsvQVy0wiah9b9n0VGDo1ovNXxn8YJv2O47SoUwgEy
	 X3/tWKU4SI1CQ==
Date: Mon, 27 Jul 2026 22:49:52 +0100
From: Will Deacon <will@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Hongyan Xia <hongyan.xia@transsion.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, Oleg Nesterov <oleg@redhat.com>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jiazi Li <jiazi.li@transsion.com>, Pu Hu <hupu@transsion.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [RFC PATCH 9/9] arm64/debug: Mark debug exception helpers
 __always_inline
Message-ID: <amfSgECpzET7JHTr@willie-the-truck>
References: <cover.1785153469.git.hongyan.xia@transsion.com>
 <eb38b41ae1b3216ec69fb45555ef5df57efd7b8d.1785153469.git.hongyan.xia@transsion.com>
 <CAKwvOd=HeG=z1j2qB-SX3NQ=62ERr=KpQNZyqqp2Qy4kZ54RLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=HeG=z1j2qB-SX3NQ=62ERr=KpQNZyqqp2Qy4kZ54RLw@mail.gmail.com>

On Mon, Jul 27, 2026 at 12:22:32PM -0700, Nick Desaulniers wrote:
> On Mon, Jul 27, 2026 at 5:25 AM Hongyan Xia <hongyan.xia@transsion.com> wrote:
> >  arch/arm64/include/asm/esr.h       | 2 +-
> >  arch/arm64/include/asm/percpu.h    | 2 +-
> >  arch/arm64/include/asm/preempt.h   | 4 ++--
> >  arch/arm64/include/asm/ptrace.h    | 4 ++--
> >  arch/arm64/kernel/debug-monitors.c | 2 +-
> >  include/linux/kprobes.h            | 8 ++++----
> 
> It might not be appropriate for the changes to kprobes.h to go through
> the arm64 tree, but maybe it is?

They look pretty trivial, so we can take 'em with Masami's Ack once the
rest of the series has been reviewed.

Will
