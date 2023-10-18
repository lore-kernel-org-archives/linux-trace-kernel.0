Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F59199CE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wm4nKJwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8DBC433C8;
	Wed, 18 Oct 2023 16:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697648152;
	bh=6Hk7cRZC8TgK8G/kxiYzsGWB7/fl5io/F1SVkvui04I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wm4nKJwnmDHFE8qeQ0f4/A9pUJJ3LalkQzT9hhfEGDZBNcFUbGV/iXAWb3ccTGzta
	 cxMsOXqtjz0Ns42jm5rhFtFCrcsuZznpuJLAq0/Z2TfXJeICK6VizaFPtzA3mijUDH
	 WK6eyJWbJnfIQ8poRiMDIUUGtJ9sFzRcA0JvxeMU=
Date: Wed, 18 Oct 2023 18:55:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 2/2] selftests/ftrace: Add new test case which checks
 non unique symbol
Message-ID: <2023101836-comprised-wreckage-77d7@gregkh>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com>
 <20231018144030.86885-3-flaniel@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018144030.86885-3-flaniel@linux.microsoft.com>

On Wed, Oct 18, 2023 at 05:40:30PM +0300, Francis Laniel wrote:
> If name_show() is non unique, this test will try to install a kprobe on this
> function which should fail returning EADDRNOTAVAIL.
> On kernel where name_show() is not unique, this test is skipped.
> 
> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> ---
>  .../ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
