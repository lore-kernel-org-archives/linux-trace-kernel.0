Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B71B0405;
	Wed, 18 Dec 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532388; cv=none; b=ktkeywaiaQC9CgTFGXfQ9B7s2SP4ZNwNeV+hDLvyOZUjhZ18sbSURNeEzNMpgwN8gvUFQcjCygEZMgwqx0VMF+wNaFP2md5FWr+/DnJGt4x6bPspxCm8Sh4fERoraOEc3BfJPynBjUBRZXuVRqt7UCN/5R9qpZcgg74CLlvkP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532388; c=relaxed/simple;
	bh=jZoIDpT5CwtoapJiCOLaGxl8KOtmocrQCr79G5dpMVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4o348vXsDii2qilhPHFucYxkxLYRULQINdaNqzEJFrjv76karhXnn0lM5f0Yx5ZdPTYzuu+6jYltcVvYDtGOIIz2O0PorO9iquZkbfQdqvjSoJIhxcMaAwhekUvcJYLNdG/wowAeRqYs+QkvzzeWovG57AzjcijSnBCWw2fDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F0BC4CED4;
	Wed, 18 Dec 2024 14:33:06 +0000 (UTC)
Date: Wed, 18 Dec 2024 09:33:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Edward Adam Davis <eadavis@qq.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, Jeongjun Park <aha310510@gmail.com>,
 david@redhat.com
Subject: Re: [PATCH] ring-buffer: Fix a oob in __rb_map_vma
Message-ID: <20241218093344.37c1dff8@gandalf.local.home>
In-Reply-To: <Z2Lcw0StqsHgU7E6@google.com>
References: <20241217124602.2d498c3f@gandalf.local.home>
	<tencent_4F9EBF1BA54B1A1B74257CBA08BB49334F08@qq.com>
	<20241217194015.7a4f0dc8@gandalf.local.home>
	<Z2KSR5QrAWYDEBVh@google.com>
	<20241218081958.55204fb3@gandalf.local.home>
	<Z2Lcw0StqsHgU7E6@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 14:31:31 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> Aside, there's a selftest to check for the overflow of subbufs with the
> mapping... but of course it didn't test with offset > nr_subbufs.
> 
> Do you think it is worth to extend it to cover this case? I'm happy to do a
> quick patch.

Yes, it should check that case.

Thanks,

-- Steve
