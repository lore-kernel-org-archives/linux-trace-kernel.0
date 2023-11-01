Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED597EA6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RI3J9782"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69848101;
	Tue, 31 Oct 2023 19:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MV80LmWK+HaIeMMiQ4lGFdPjZ/dKd3eVttELJDWLh68=; b=RI3J9782cDMmJx55FEMVvTVcQR
	/I1+r9nljUduVvfY9rzEWaTk0abHH1QGmuRrErNK3gQExgcaHNNzhV6sbt/TOkbvUJ4oSNxXqXzJo
	6SAR7d3Cz7YlGTL/HBi2e0yvPakQ/iLqiCGUQ4+nkdB+WNiGvEGG5Wek9MwO7os599tlYCDHWr/yu
	CVKsoc8Kztk/zSTIgE3c4NckL7OS0K0zZjEZ40PN/P6tsgbtBXHK/Jxq29J9pm3YxuofKTllw72um
	omQoADKdxVfnpKV8Pxj+yRoSXSlvKeTGS8aLUz+gH6O4fW08ONRWnePkQNSvQNTaPSGKAEIKKK5XY
	OTsYCyJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy0vZ-008ktj-1J;
	Wed, 01 Nov 2023 02:25:53 +0000
Date: Wed, 1 Nov 2023 02:25:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH] eventfs: Process deletion of dentry more thoroughly
Message-ID: <20231101022553.GE1957730@ZenIV>
References: <20231031144703.71eef3a0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031144703.71eef3a0@gandalf.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 31, 2023 at 02:47:03PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Looking at how dentry is removed via the tracefs system, I found that
> eventfs does not do everything that it did under tracefs. The tracefs
> removal of a dentry calls simple_recursive_removal() that does a lot more
> than a simple d_invalidate().

Umm...  Is there any reason not to use simple_recursive_removal() there?
