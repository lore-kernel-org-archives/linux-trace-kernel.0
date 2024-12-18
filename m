Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB8155CA5;
	Wed, 18 Dec 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527963; cv=none; b=W9JGDRQU3b+Cd56B0lfoVYMVs9rjG1B2FgMVYCEY5Ys7WaMJ2Bdi534wBM3RuHU4s4aF0QzF0WjGuSejZCokTZ4QRYrprz/B0H4LQhQb67UdpfctKLG2BVSNzwmgE0sFjldqdoBbAw0CcsRX5YmlnoI3ROFu0+II+FX0cgjn4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527963; c=relaxed/simple;
	bh=cyZle3E1CfpNiVdCRhzgkvMciODeZ0pVP4sR4LfVGRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyYTbYiBeZdXR8GWtKLciw38EweIR4JPRNJ6vqDTpfwrDRuWMAdatYY10zd4+pGcpFtVTdd9cMU7/8zsnfu2S/z+5wg+pntyj5LahlNscJoWCTu7DUlCKBHlNfbhDKCsra1q4FyXPEvEgX54kWDVKM2jdMwN5kua9pjcidGFjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F4BC4CECE;
	Wed, 18 Dec 2024 13:19:21 +0000 (UTC)
Date: Wed, 18 Dec 2024 08:19:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Edward Adam Davis <eadavis@qq.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, Jeongjun Park <aha310510@gmail.com>,
 david@redhat.com
Subject: Re: [PATCH] ring-buffer: Fix a oob in __rb_map_vma
Message-ID: <20241218081958.55204fb3@gandalf.local.home>
In-Reply-To: <Z2KSR5QrAWYDEBVh@google.com>
References: <20241217124602.2d498c3f@gandalf.local.home>
	<tencent_4F9EBF1BA54B1A1B74257CBA08BB49334F08@qq.com>
	<20241217194015.7a4f0dc8@gandalf.local.home>
	<Z2KSR5QrAWYDEBVh@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 09:13:43 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> And probably also 
> 
> Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")

I don't require patch submitters to add Fixes tags. It's more the
responsibility of the maintainer to do that. I still have to validate it as
there's been several times someone adds a Fixes tag which wasn't the right
commit that it fixed.

-- Steve
