Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429941E8856;
	Wed, 30 Oct 2024 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331610; cv=none; b=OaLfdLb5HmSqGZVf9zey/EyIR8zv4X1M/iuW3DeOFHwMFxdUcdoR7Xz8fazaorcwcmJq4WWpRzxwsoYCaGye3KjksKSzsUdrQC0NZWvo+5MjRB+B0RW/DZUobwORNBh3G+6IoSf3/WSIEIdWRZc+R8utALwyk/KPEDqOjgbaWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331610; c=relaxed/simple;
	bh=P54VmbAjUDEuc9ALM89/kQ517bvFtFpeh51kBjdxCT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+VO3xp/1Toyl7qCLLVJjTCAV/wJAn9ShzxRU6RsUFUUBWfq9AmDO3mh9FekoVu7phuNjqQEjuJlnHHzEZCrOxzKPaxN4YS/li9+RzZbPFO2EBHUxdicz3M1LURB3+LC6++lyLz0S9nUFWEArJRSSKw9AlBpo7lXzbGaYgMVBVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53114C4E692;
	Wed, 30 Oct 2024 23:40:09 +0000 (UTC)
Date: Wed, 30 Oct 2024 19:40:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Replace strncpy() with strscpy() when copying
 comm
Message-ID: <20241030194006.4d29417c@rorschach.local.home>
In-Reply-To: <20240731075058.617588-1-ruanjinjie@huawei.com>
References: <20240731075058.617588-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jul 2024 15:50:58 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 6ece1308d36a..4ee0e64719fa 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1599,7 +1599,7 @@ static inline void save_comm(char *comm, struct tas=
k_struct *task)
>  		return;
>  	}
> =20
> -	strncpy(comm, task->comm, TASK_COMM_LEN);
> +	strscpy(comm, task->comm);
>  }
> =20

Was this even compiled?

In file included from /work/git/test-linux.git/include/linux/container_of.h=
:5,
                 from /work/git/test-linux.git/include/linux/list.h:5,
                 from /work/git/test-linux.git/include/linux/module.h:12,
                 from /work/git/test-linux.git/kernel/trace/trace_events_hi=
st.c:8:
/work/git/test-linux.git/kernel/trace/trace_events_hist.c: In function =E2=
=80=98save_comm=E2=80=99:
/work/git/test-linux.git/include/linux/build_bug.h:16:51: error: negative w=
idth in bit-field =E2=80=98<anonymous>=E2=80=99
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); }=
)))
      |                                                   ^
/work/git/test-linux.git/include/linux/compiler.h:243:33: note: in expansio=
n of macro =E2=80=98BUILD_BUG_ON_ZERO=E2=80=99
  243 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), =
&(a)[0]))
      |                                 ^~~~~~~~~~~~~~~~~
/work/git/test-linux.git/include/linux/string.h:79:47: note: in expansion o=
f macro =E2=80=98__must_be_array=E2=80=99
   79 |         sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) =
+    \
      |                                               ^~~~~~~~~~~~~~~
/work/git/test-linux.git/include/linux/args.h:25:24: note: in expansion of =
macro =E2=80=98__strscpy0=E2=80=99
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
/work/git/test-linux.git/include/linux/args.h:26:27: note: in expansion of =
macro =E2=80=98__CONCAT=E2=80=99
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
/work/git/test-linux.git/include/linux/string.h:113:9: note: in expansion o=
f macro =E2=80=98CONCATENATE=E2=80=99
  113 |         CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, _=
_VA_ARGS__)
      |         ^~~~~~~~~~~
/work/git/test-linux.git/kernel/trace/trace_events_hist.c:1602:9: note: in =
expansion of macro =E2=80=98strscpy=E2=80=99
 1602 |         strscpy(comm, task->comm);
      |         ^~~~~~~

Bah!

-- Steve
