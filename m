Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E709463DF
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Oct 2023 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4D7C433C8;
	Sun, 29 Oct 2023 13:14:10 +0000 (UTC)
Date: Sun, 29 Oct 2023 09:14:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "Naresh Kamboju <naresh.kamboju@linaro.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Ajay Kaher <akaher@vmware.com>, Andrew Morton"
 <akpm@linux-foundation.org>, lkft-triage@lists.linaro.org
Subject: Re: [PATCH v2] eventfs: Test for ei->is_freed when accessing
 ei->dentry
Message-ID: <20231029091408.0179cee4@rorschach.local.home>
In-Reply-To: <CA+G9fYsL=wK_rn8ovCHtn6QXrvzv0a67oj9U3u6r9i-dxjsqwQ@mail.gmail.com>
References: <20231028164650.4f5ea18a@rorschach.local.home>
	<CA+G9fYsL=wK_rn8ovCHtn6QXrvzv0a67oj9U3u6r9i-dxjsqwQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Oct 2023 12:31:54 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Following build errors have been noticed.
> 
> fs/tracefs/event_inode.c:348:1: error: return type defaults to 'int'
> [-Werror=implicit-int]
>   348 | create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
>       | ^~~~~~~~~~~~~~~~~
> In file included from include/uapi/linux/posix_types.h:5,
>                  from include/uapi/linux/types.h:14,
>                  from include/linux/types.h:6,
>                  from include/linux/kasan-checks.h:5,
>                  from include/asm-generic/rwonce.h:26,
>                  from ./arch/x86/include/generated/asm/rwonce.h:1,

This patch passed all my tests, I have no idea how the above happened.
The "return type defaults to int" tells me the "static struct dentry *"
part of the patch may have been clipped.

Are you sure it was applied correctly? Perhaps check out the branch I
have and let me know if you get the same errors.

git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace/core

-- Steve
