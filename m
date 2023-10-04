Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62715ACB
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1261BC433C8;
	Wed,  4 Oct 2023 15:13:30 +0000 (UTC)
Date: Wed, 4 Oct 2023 11:14:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 cleger@rivosinc.com, linux-kselftest@vger.kernel.org, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
Message-ID: <20231004111437.47c80c81@gandalf.local.home>
In-Reply-To: <4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
	<20230925230829.341-3-beaub@linux.microsoft.com>
	<20231003205908.391d17f5@gandalf.local.home>
	<4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Oct 2023 09:10:52 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 10/3/23 18:59, Steven Rostedt wrote:
> > 
> > Note, this doesn't seem to apply to my tree so I only added the first
> > patch. I think this needs to go through Shuah's tree.
> > 
> > -- Steve
> > 
> >   
> 
> Yes. I sent a fix up for rc4 - I can pull these two patches into
> linux-kselftest next
> 
> Steve! Does that work for you?
> 

I applied the first patch to my tree, I think the second patch is fine to go
separately through your tree.

-- Steve
