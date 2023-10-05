Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDF23AC1B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D7EC433C8;
	Thu,  5 Oct 2023 17:44:51 +0000 (UTC)
Date: Thu, 5 Oct 2023 13:46:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 cleger@rivosinc.com, linux-kselftest@vger.kernel.org, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
Message-ID: <20231005134600.0b309226@gandalf.local.home>
In-Reply-To: <20231005165230.GA1247-beaub@linux.microsoft.com>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
	<20230925230829.341-3-beaub@linux.microsoft.com>
	<20231003205908.391d17f5@gandalf.local.home>
	<4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
	<20231004111437.47c80c81@gandalf.local.home>
	<55213463-8834-4ed6-b0a2-1be69dd838d2@linuxfoundation.org>
	<c6ddb83d-acd8-47d0-8946-5a9b64c65d03@linuxfoundation.org>
	<20231005110816.4b68453d@gandalf.local.home>
	<20231005165230.GA1247-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 09:52:30 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:


> It was based on tracing/for-next.
> 
> I'll get a v2 out rebased upon linux-kselftest, does that work?

Hmm, then it should have applied to my tree. I didn't look too deep.

Can you see if it applies to:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

    trace/for-next ?

Thanks,

-- Steve
