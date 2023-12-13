Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eFvtTxVs"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 016D3113;
	Wed, 13 Dec 2023 10:36:16 -0800 (PST)
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id B38EB20B74C0;
	Wed, 13 Dec 2023 10:36:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B38EB20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702492576;
	bh=FSoND/Rio1BVDzv9hjpwr5UcJ+QwyY4n+ZrOMk4me1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFvtTxVsiFesSJ7FzNixa281/P48b0bCJxgm3CqQ6cDk6s6Skcl2acTUa8gUBEXES
	 tTYVpdre+532OpyaTWruMgobqgik30bvZ7aLrPx3eAdDHUG2SFi4aEiOKN+F7WeSwQ
	 1SA8Nb68mNFCR3UPRRDsdzlKrPWDm7wHEPPCAtI0=
Date: Wed, 13 Dec 2023 10:36:14 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, arnd@arndb.de,
	pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/15] kexec: Add Kexec HandOver (KHO) generation helpers
Message-ID: <20231213183614.GA14669@skinsburskii.>
References: <20231213000452.88295-1-graf@amazon.com>
 <20231213000452.88295-4-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213000452.88295-4-graf@amazon.com>

On Wed, Dec 13, 2023 at 12:04:40AM +0000, Alexander Graf wrote:
> +int register_kho_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&kho.chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(register_kho_notifier);
> +
> +int unregister_kho_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&kho.chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(unregister_kho_notifier);
> +
> +bool kho_is_active(void)
> +{
> +	return kho.active;
> +}
> +EXPORT_SYMBOL_GPL(kho_is_active);
> +

Why should these helpers be restricted to GPL code?

