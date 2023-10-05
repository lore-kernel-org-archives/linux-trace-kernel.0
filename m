Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48270107A0
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA98C433C8;
	Thu,  5 Oct 2023 15:07:08 +0000 (UTC)
Date: Thu, 5 Oct 2023 11:08:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 cleger@rivosinc.com, linux-kselftest@vger.kernel.org, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
Message-ID: <20231005110816.4b68453d@gandalf.local.home>
In-Reply-To: <c6ddb83d-acd8-47d0-8946-5a9b64c65d03@linuxfoundation.org>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
	<20230925230829.341-3-beaub@linux.microsoft.com>
	<20231003205908.391d17f5@gandalf.local.home>
	<4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
	<20231004111437.47c80c81@gandalf.local.home>
	<55213463-8834-4ed6-b0a2-1be69dd838d2@linuxfoundation.org>
	<c6ddb83d-acd8-47d0-8946-5a9b64c65d03@linuxfoundation.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 08:48:14 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> Hmm. Which tree is this patch based on? This doesn't apply to
> linux-kselftest fixes - I thought this was based on top of fixes
> since I sent in a fix for Linux 6.6-rc4 for user_events
> 
> Beau, Please rebase to the correct tree/branch and send v2 for
> this patch.

Hmm, so this didn't apply to my tree nor yours.

Beau, can you verify which tree this goes to?

-- Steve
