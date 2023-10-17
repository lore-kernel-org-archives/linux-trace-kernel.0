Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E2450FF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C29C433C8;
	Tue, 17 Oct 2023 17:36:09 +0000 (UTC)
Date: Tue, 17 Oct 2023 13:37:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yu Liao <liaoyu15@huawei.com>
Cc: <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
 <shuah@kernel.org>, <liwei391@huawei.com>, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH -next 0/2] add loongarch and riscv support for kprobe
 args test
Message-ID: <20231017133745.098244d1@gandalf.local.home>
In-Reply-To: <20230815085912.701356-1-liaoyu15@huawei.com>
References: <20230815085912.701356-1-liaoyu15@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 16:59:10 +0800
Yu Liao <liaoyu15@huawei.com> wrote:

> Yu Liao (2):
>   selftests/ftrace: add loongarch support for kprobe args char tests
>   selftests/ftrace: Add riscv support for kprobe arg tests
> 
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc      | 6 ++++++
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc    | 3 +++
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc    | 4 ++++
>  3 files changed, 13 insertions(+)
> 

I noticed that this never got picked up, but that's probably because it
didn't also Cc linux-kselftest@vger.kernel.org (which I did here).

Shuah,

Can you add this? You can also add:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
